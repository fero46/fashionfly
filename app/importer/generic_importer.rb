 #encoding: utf-8 
require 'xml'
require 'fileutils'
require 'open-uri'

class GenericImporter

  def initialize affiliate
    @affiliate = affiliate
    @scope = @affiliate.scope
  end

  def categories
    categories = []
    document.root.children.each do |tag|
      if tag.name == @affiliate.item_tag
        tag.children.each do |t|
          categories << t.content if t.name == @affiliate.category_tag
        end
      end
    end
    categories.uniq
  end

  def import
    total_counter = total_count
    actual_counter = 0
    document.root.children.each do |tag|
      if tag.name == @affiliate.item_tag
        actual_counter+=1
        if actual_counter % 20 == 0
          @affiliate.percent = ((actual_counter.to_f/total_counter.to_f).to_f * 100).to_i
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

        if find_mapping(product_category(values)).present?
          next if product_remote_image(values).blank?
          product = Product.where(affiliate_id: @affiliate.id, 
                                  affi_code: id,
                                  scope_id: @scope.id).first_or_create
          product.premium = @affiliate.premium
          product.save
          Categorization.where(product_id: product.id).destroy_all
          update_product_categories(product, values)
          next if product.lastModified==product_last_modified(values)
          product = update_product_attributes product, values
          update_product_images product, values
        else
          product = Product.where(affiliate_id: @affiliate.id, 
                        affi_code: id,
                        scope_id: @scope.id).first
          if product.present?
            product.published = false
            product.save
          end
        end
        @affiliate.skip_items = actual_counter
        @affiliate.save
      end
    end
    @affiliate.skip_items = 0
    @affiliate.percent = 100
    @affiliate.save
    true
  end

  def total_count
    counter = 0
    document.root.children.each do |tag|
        counter+=1 if tag.name == @affiliate.item_tag
    end
    counter
  end

protected

  def update_product_images product, values
    remote_image_path = product_remote_image(values)
    import_product_image(product, values, remote_image_path)
  end


  def import_product_image product, values, remote_image_path
    ImageCropService.new(product, remote_image_path).image_cut_out
  end

  def update_product_attributes product, values
    product.name=product_name(values)
    product.number=product_number(values)
    product.description=product_description(values)
    brand = Brand.where(name: product_brand(values)).first_or_create
    product.brand_id = brand.id
    product.ean=product_ean(values)
    product.price=product_price(values)
    product.shippingHandlingCost=product_shipment_cost(values)
    product.lastModified=product_last_modified(values)
    product.deliveryTime=product_delivery_time(values)
    product.currencyCode=product_currency(values)
    product.deepLink=product_link(values)
    product
  end


  def update_product_categories(product, values)
    category = find_mapping(product_category(values))
    while category.present? do
      next if category.blank? 
      Categorization.where(product_id: product.id, category_id: category.id).first_or_create
      category = category.category
    end
  end

  def product_remote_image values
    image_tags = @affiliate.image_tag.split(',')
    for image_tag in image_tags
       result = values[image_tag.strip!] 
       return result if result.present?
    end
    nil
  end

  def product_link values
    values[@affiliate.link_tag]
  end

  def product_currency values
    values[@affiliate.currency_code_tag]
  end    

  def product_delivery_time values
    values[@affiliate.delivery_time_tag]
  end

  def product_last_modified values
    values[@affiliate.last_modified_tag]
  end

  def product_shipment_cost values
    values[@affiliate.shipping_cost_tag]
  end


  def product_price values
    values[@affiliate.price_tag]
  end

  def product_ean values
    values[@affiliate.ean_tag]
  end

  def product_brand values
    values[@affiliate.brand_tag]
  end

  def product_description values
    values[@affiliate.description_tag]
  end

  def product_number values
    values[@affiliate.number_tag]
  end


  def product_name values
    values[@affiliate.name_tag]
  end

  def product_brand values
    values[@affiliate.brand_tag]
  end

  def product_category values
    values[@affiliate.category_tag]
  end

  def product_last_modified values
    values[@affiliate.last_modified_tag]
  end

  def has_mapping name
    mapper[name].present?
  end

  def find_mapping name
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
    @document if @document.present?
    xml = open(@affiliate.file.path) {|f| f.read }
    source = XML::Parser.string(xml)
    @document = source.parse
  end

  def clean_name name
    name.gsub('ö', 'oe').gsub('ü', 'ue').gsub('ä', 'ae').gsub('ß','ss').gsub('%', '').gsub(' ','_')
  end

end