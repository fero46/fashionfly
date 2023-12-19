# frozen_string_literal: true

class AffilinetImporter < GenericImporter
  MAIN_ROOT = 'Products'
  ITEM_ROOT = 'Product'
  ITEM_CATEGORY_PATH = 'CategoryPath'
  ITEM_CATEGORY = 'ProductCategoryPath'

  PRODUCT_LINK_TAG = 'Deeplinks'
  PRICE = 'Price'
  DISPLAY_PRICE = 'DisplayPrice'
  CURRENCY = 'currency'
  DEEP_LINKS = 'Deeplinks'
  DETAILS = 'Details'
  DescriptionShort = 'DescriptionShort'
  KEYWORDS = 'Keywords'
  MANUFACTURER = 'Manufacturer'
  DESCRIPTION = 'DescriptionShort'
  TITLE = 'Title'
  IMAGES = 'Images'
  IMG = 'Img'
  NUMBER = 'ArticleNumber'

  def categories
    nodes = children_from_tag [document.root], ITEM_ROOT
    #    nodes = children_from_tag nodes, ITEM_ROOT
    nodes = children_from_tag nodes, ITEM_CATEGORY_PATH
    nodes = children_from_tag nodes, ITEM_CATEGORY
    nodes.map(&:content).uniq.sort
  end

  def import
    nodes = children_from_tag [document.root], ITEM_ROOT
    total_counter = nodes.length
    actual_counter = 0
    @affiliate.products.update_all(dirty: true)
    nodes.each do |node|
      actual_counter += 1
      if (actual_counter % 20).zero?
        @affiliate.percent = ((actual_counter.to_f / total_counter).to_f * 100).to_i
        @affiliate.save
      end
      next if @affiliate.skip_items > actual_counter

      values = {}
      id = nil
      node.attributes.each do |a|
        id = a.value if a.name == 'ArticleNumber' || a.name == 'zupid'
      end
      values[NUMBER] = id
      node.children.each do |first_level|
        check_category_node(first_level, values)
        check_price(first_level, values)
        check_deeplinks(first_level, values)
        check_details(first_level, values)
        check_images(first_level, values)
      end

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
    true
  end

  protected

  def check_images(node, values)
    return unless node.name == IMAGES

    node.children.each do |cat|
      values[IMAGES] = cat.content if cat.name == IMG
    end
  end

  def check_details(node, values)
    return unless node.name == DETAILS

    node.children.each do |cat|
      values[MANUFACTURER] = cat.content if cat.name == MANUFACTURER
      values[DESCRIPTION] = cat.content if cat.name == DESCRIPTION
      values[TITLE] = cat.content if cat.name == TITLE
    end
  end

  def check_deeplinks(node, values)
    return unless node.name == DEEP_LINKS

    node.children.each do |cat|
      values[DEEP_LINKS] = cat.content if cat.name == ITEM_ROOT
    end
  end

  def check_price(node, values)
    return unless node.name == PRICE

    node.children.each do |cat|
      next unless cat.name == DISPLAY_PRICE

      display_price = cat.content.split(' ')
      values[CURRENCY] = display_price[1]
      values[PRICE] = display_price[0]
    end
  end

  def check_category_node(node, values)
    return unless node.name == ITEM_CATEGORY_PATH

    node.children.each do |cat|
      values[ITEM_CATEGORY] = cat.content if cat.name == ITEM_CATEGORY
    end
  end

  def should_not_update(product, values)
    product.name == product_name(values) || product_remote_image(values).blank?
  end

  def children_from_tag(parents, name)
    collect = []
    parents.each do |parent|
      parent.children.each do |child|
        collect << child if child.name == name
      end
    end
    collect
  end

  def product_link(values)
    values[DEEP_LINKS]
  end

  def product_currency(values)
    values[CURRENCY]
  end

  def product_remote_image(values)
    values[IMAGES]
  end

  def product_delivery_time(_values)
    nil
  end

  def product_last_modified(_values)
    nil
  end

  def product_shipment_cost(_values)
    nil
  end

  def product_price(values)
    values[PRICE]
  end

  def product_ean(values)
    values[NUMBER]
  end

  def product_brand(values)
    values[MANUFACTURER]
  end

  def product_description(values)
    values[DESCRIPTION]
  end

  def product_number(values)
    values[NUMBER]
  end

  def product_name(values)
    values[TITLE]
  end

  def product_category(values)
    values[ITEM_CATEGORY]
  end
end
