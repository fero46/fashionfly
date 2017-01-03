require 'net/http'
require 'uri'

class ReklamActionImporter < AffilinetImporter
  include ActionView::Helpers::SanitizeHelper

  MAIN_ROOT = 'Products'
  ITEM_ROOT = 'Product'
  MAIN_CAT = "MainCategory"
  SUBCAT = "ChildrenCategory"
  FullDesc = "FullDesc"
  PRICE = "ListPrice"
  SALE = "SalePrice"
  CURRENCY = "Currency"
  IMG = "Image"
  MANUFACTURER = "Brand"
  DESCRIPTION = "FullDesc"
  NAME = "Title"
  DEEP_LINKS = "URL"
  GENDER = 'Gender'

  def import
    nodes = children_from_tag([document.root], MAIN_ROOT)
    nodes = children_from_tag(nodes, ITEM_ROOT)
    total_counter = nodes.length
    actual_counter = 0
    @affiliate.products.update_all(dirty: true)
    for node in nodes

      next if node.name != ITEM_ROOT

      actual_counter += 1
      if actual_counter % 20 == 0
          @affiliate.percent = ((actual_counter.to_f/total_counter.to_f).to_f * 100).to_i
          @affiliate.save
      end
      next if @affiliate.skip_items > actual_counter
      values = {}

      chack_article_number(node, values)
      check_category_node(node, values)
      check_price(node, values)
      check_details(node, values)
      check_deeplinks(node, values)
      if find_mapping(product_category(values)).present?
        node.children.each do |first_level|
          check_images(first_level, values)
        end
      end
      id = values[NUMBER]


      insert_values(id, values)
      @affiliate.skip_items = actual_counter
      @affiliate.save
    end
    @affiliate.products.where(dirty: true).where(removed: false).map{|x| RemoverWorker.run(x)}
    @affiliate.skip_items = 0
    @affiliate.percent = 100
    @affiliate.ready = false
    @affiliate.importing = false
    @affiliate.save
  end

  def should_not_update product, values
    return false
  end

  def categories
    list = []
    nodes = children_from_tag([document.root], MAIN_ROOT)[0]
    for node in nodes.children
      if node.name == ITEM_ROOT
        list << find_category(node)
      end
    end
    list.uniq.sort
  end

  def check_deeplinks
    x
  end

  def check_images node, values
    if node.name == IMAGES
      node.children.each do |cat|
        values[IMAGES]=cat.content if cat.name == IMG && cat.content.present?
      end
    end
    if values[IMAGES].present?
      values[IMAGES] =  RedirectFollower.new(values[IMAGES]).resolve.url
    end
    values[IMAGES]
  end

  def check_details node, values
    node.children.each do |cat|
      values[MANUFACTURER]=strip_tags(cat.content) if cat.name == MANUFACTURER
      values[DESCRIPTION]=strip_tags(cat.content) if cat.name == DESCRIPTION
      values[TITLE]= strip_tags(cat.content) if cat.name == TITLE
    end
  end

  def check_deeplinks node, values
    node.children.each do |link|
      values[DEEP_LINKS] = link.content if link.name == DEEP_LINKS
    end
  end

  def check_price node, values
    price = 0
    sale = 0
    currency  = ""
    for cnode in node.children
      price = cnode.content if cnode.name == PRICE
      sale = cnode.content if cnode.name == SALE
      currency = cnode.content if cnode.name == CURRENCY
    end
    values[PRICE] = price
    values[SALE] = sale
    values[CURRENCY] = currency
  end

  def chack_article_number node, values
    values[NUMBER] = find_code(node)
  end

  def check_category_node node, values
    values[ITEM_CATEGORY] = find_category(node)
  end

  def find_code node
    for subnode in node.children
      return subnode.content if subnode.name == "Code"
    end
  end

  def find_category node
    sexes = nil
    cat = ""
    for subnode in node.children
      if subnode.name ==  MAIN_CAT || subnode.name == SUBCAT
        cat = "#{cat} - " if cat != ""
        cat = "#{cat}#{subnode.content}"
      end
      if subnode.name == FullDesc
        content = subnode.content
        if content.include? "bayan"
          sexes = "BAYAN"
        elsif content.include? "erkek"
          sexes = "ERKEK"
        else
          sexes = nil
        end
      end
      if subnode.name == GENDER
        content = subnode.content
        if content == "M" || content == "m"
          sexes = "ERKEK"
        elsif content == "F" || content == "f"
          sexes = "BAYAN"
        end
      end
    end
    cat = "#{sexes} - #{cat}" if sexes.present?
    cat
  end

  def sale_price(values)
    values[SALE]
  end

  def is_sale?(values)
    begin
      if values[PRICE].present? && values[SALE].present?
        return values[PRICE].to_f != values[SALE].to_f
      end
    rescue
      return false
    end
  end


  def product_link values
    values[DEEP_LINKS]
  end

  def product_currency values
    values[CURRENCY]
  end

  def product_remote_image values
    values[IMAGES]
  end

  def product_delivery_time values
    nil
  end

  def product_last_modified values
    nil
  end

  def product_shipment_cost values
    nil
  end


  def product_price values
    values[PRICE]
  end

  def product_ean values
      values[NUMBER]
  end

  def product_brand values
    values[MANUFACTURER]
  end

  def product_description values
    values[DESCRIPTION]
  end

  def product_number values
    values[NUMBER]
  end


  def product_name values
    values[TITLE]
  end

  def product_category values
    values[ITEM_CATEGORY]
  end

end
