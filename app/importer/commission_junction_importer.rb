# frozen_string_literal: true

class CommissionJunctionImporter < GenericImporter
  PRODUCT = 'product'
  CATEGORY = 'advertisercategory'
  UPC = 'upc'

  def categories
    categories = []
    document.root.children.each do |tag|
      if tag.name == PRODUCT
        cat = filter_category(tag)
        categories << cat if cat.present?
      end
    end
    categories.uniq
  end

  def import
    total_counter = total_count
    actual_counter = 0
    @affiliate.products.update_all(dirty: true)
    document.root.children.each do |tag|
      values = {}
      next unless tag.name == PRODUCT

      actual_counter += 1
      if (actual_counter % 20).zero?
        @affiliate.percent = ((actual_counter.to_f / total_counter).to_f * 100).to_i
        @affiliate.save
      end
      next if @affiliate.skip_items > actual_counter

      tag.children.each do |t|
        values[t.name] = t.content
      end
      id = values[@affiliate.ean_tag.strip]
      insert_values(id, values)
      @affiliate.skip_items = actual_counter
      @affiliate.save
    end
    @affiliate.products.where(dirty: true).where(removed: false).map { |x| RemoverWorker.run(x) }
    @affiliate.skip_items = 0
    @affiliate.percent = 100
    @affiliate.ready = false
    @affiliate.importing = false
    @affiliate.save
  end

  def product_remote_image(values)
    values[@affiliate.image_tag]
  end

  def total_count
    counter = 0
    document.root.children.each do |tag|
      counter += 1 if tag.name == PRODUCT
    end
    counter
  end

  def product_name(values)
    begin
      name = super.split(' ').map { |w| w.gsub(/(\W|\d)/, '') }.reject!(&:empty?).join(' ')
    rescue StandardError
      name = super
    end
    remove_size_from_name(name)
  end

  def remove_size_from_name(string)
    my_array = string.split(' ')
    new_array = []
    my_array.each do |item|
      item = item.gsub('L', '').gsub('M', '').gsub('S', '') if item.length == 1
      item = item.gsub('XL', '').gsub('XS', '') if item.length == 2
      item = item.gsub('XXL', '') if item.length == 3
      new_array << item if item.length.positive?
    end
    new_array.join(' ')
  end

  def filter_category(node)
    node.children.each do |tag|
      return tag.content if tag.name == @affiliate.category_tag
    end
    'IGNORED'
  end
end
