# encoding: utf-8
require 'xml'
require 'fileutils'
require 'open-uri'

class GenericImporter
  def initialize(affiliate)
    @affiliate = affiliate
    @scope = @affiliate.scope
  end

  def categories
    categories = []
    document.root.children.each do |tag|
      next unless tag.name == @affiliate.item_tag
      tag.children.each do |t|
        categories << t.content if t.name == @affiliate.category_tag
      end
    end
    categories.uniq
  end

  def import
    total_counter = total_count
    actual_counter = 0
    @affiliate.products.update_all(dirty: true)
    document.root.children.each do |tag|
      next unless tag.name == @affiliate.item_tag
      actual_counter += 1
      if (actual_counter % 20).zero?
        @affiliate.percent = ((actual_counter.to_f / total_counter.to_f).to_f * 100).to_i
        @affiliate.save
      end
      next if @affiliate.skip_items > actual_counter
      id = nil
      tag.attributes.each do |a|
        id = a.value if a.name == 'id' || a.name == 'zupid'
      end
      values = {}
      tag.children.each do |t|
        values[t.name] = t.content
      end
      insert_values id, values
      @affiliate.skip_items = actual_counter
      @affiliate.save
    end
    @affiliate.products.where(dirty: true).where(published: false).map{|x| RemoverWorker.run(x)}
    @affiliate.skip_items = 0
    @affiliate.percent = 100
    @affiliate.save
    true
  end

  def insert_values(id, values)
    product = nil
    begin
    if find_mapping(product_category(values)).present?
      return if product_remote_image(values).blank?
      product = Product.where(affiliate_id: @affiliate.id,
                              affi_code: id,
                              scope_id: @scope.id).first_or_create
      product.premium = @affiliate.premium
      product.save
      Categorization.where(product_id: product.id).destroy_all
      update_product_categories(product, values)
      product = update_product_attributes product, values
      begin
        update_product_images(product, values) if product.image.blank? || product.original.blank?
      rescue
        product.destroy
        return
      end
      product.update(published: true)
      product.save!
    end
  rescue Exception => e
    puts e
    product.destroy if product.present?
  end
  end

  def total_count
    counter = 0
    document.root.children.each do |tag|
      counter += 1 if tag.name == @affiliate.item_tag
    end
    counter
  end

  protected

  def update_product_images(product, values)
    remote_image_path = product_remote_image(values)
    raise "Remote Image ist Leer #{values}" if remote_image_path.blank?
    import_product_image(product, values, remote_image_path)
  end

  def import_product_image(product, _values, remote_image_path)
    ImageCropService.new(product, remote_image_path).image_cut_out
  end

  def update_product_attributes(product, values)
    product.name = product_name(values)
    product.number = product_number(values)
    product.description = product_description(values)
    brand = Brand.where(name: product_brand(values)).first_or_create
    product.brand_id = brand.id
    product.ean = product_ean(values)
    begin
      if !product.new_record? && product.price.to_f > product_price(values).to_f && !sale_price(values)
        product.sale_price = product_price(values)
        product.is_sale = true
      else
        product.price = product_price(values)
        product.sale_price = sale_price(values)
        product.sale = is_sale?(values)
      end
    rescue
      product.price = product_price(values)
      product.sale_price = sale_price(values)
      product.sale = is_sale?(values)
    end
    product.shippingHandlingCost = product_shipment_cost(values)
    product.lastModified = product_last_modified(values)
    product.deliveryTime = product_delivery_time(values)
    product.currencyCode = product_currency(values)
    product.deepLink = product_link(values)
    product.colorization_id = 1 if product.colorization_id.blank?
    product.dirty = false
    product.save
    product
  end

  def update_product_categories(product, values)
    category = find_mapping(product_category(values))
    while category.present?
      next if category.blank?
      Categorization.where(product_id: product.id, category_id: category.id).first_or_create
      category = category.category
    end
  end

  def product_remote_image(values)
    image_tags = @affiliate.image_tag.split(',')
    for image_tag in image_tags
      result = values[image_tag.strip]
      return result if result.present?
    end
    nil
  end

  def sale_price(_values)
    nil
  end

  def is_sale?(_values)
    false
  end

  def product_link(values)
    values[@affiliate.link_tag]
  end

  def product_currency(values)
    values[@affiliate.currency_code_tag]
  end

  def product_delivery_time(values)
    values[@affiliate.delivery_time_tag]
  end

  def product_last_modified(values)
    values[@affiliate.last_modified_tag]
  end

  def product_shipment_cost(values)
    values[@affiliate.shipping_cost_tag]
  end

  def product_price(values)
    values[@affiliate.price_tag]
  end

  def product_ean(values)
    values[@affiliate.ean_tag]
  end

  def product_brand(values)
    values[@affiliate.brand_tag]
  end

  def product_description(values)
    values[@affiliate.description_tag]
  end

  def product_number(values)
    values[@affiliate.number_tag]
  end

  def product_name(values)
    values[@affiliate.name_tag]
  end

  def product_brand(values)
    values[@affiliate.brand_tag]
  end

  def product_category(values)
    values[@affiliate.category_tag]
  end

  def product_last_modified(values)
    values[@affiliate.last_modified_tag]
  end

  def has_mapping(name)
    mapper[name].present?
  end

  def find_mapping(name)
    mapper[name]
  end

  def mapper
    @mapper = loadmapper
  end

  def loadmapper
    result = {}
    for mapping in @affiliate.mappings
      result[mapping.name] = mapping.category
    end
    result
  end

  def document
    return nil if @affiliate.file.blank?
    begin
      @document if @document.present?

      path = @affiliate.file.path
      begin
        source = open(path)
        gz = Zlib::GzipReader.new(source)
        xml = gz.read
      rescue Exception => e
        puts e.to_s
        puts 'READ REAL'
        xml = open(@affiliate.file.path, &:read)
      end

      source = XML::Parser.string(xml)
      @document = source.parse
    rescue Exception => e
      puts e.to_s
      return nil
    end
  end

  def clean_name(name)
    name.gsub('ö', 'oe').gsub('ü', 'ue').gsub('ä', 'ae').gsub('ß', 'ss').delete('%').tr(' ', '_')
  end
end
