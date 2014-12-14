class AffilinetImporter < GenericImporter

  MAIN_ROOT = 'Products'
  ITEM_ROOT = 'Product'
  ITEM_CATEGORY_PATH ='CategoryPath'
  ITEM_CATEGORY = 'ProductCategoryPath'

  PRODUCT_LINK_TAG = 'Deeplinks'
  PRICE = 'Price'
  DISPLAY_PRICE = 'DisplayPrice'
  CURRENCY = 'currency'
  DEEP_LINKS= 'Deeplinks'
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
    nodes.map{|i| i.content}.uniq.sort
  end

  def import
    nodes = children_from_tag [document.root], ITEM_ROOT
    total_counter = nodes.length
    actual_counter = 0
    for node in nodes
      actual_counter += 1
      if actual_counter % 20 == 0
          @affiliate.percent = ((actual_counter.to_f/total_counter.to_f).to_f * 100).to_i
          @affiliate.save
      end
      values = {}
      id = nil
      node.attributes.each do |a|
        id = a.value if a.name == 'ArticleNumber' || a.name == 'zupid'
      end
      values[NUMBER] = id
      node.children.each do |first_level|
        if first_level.name == ITEM_CATEGORY_PATH
          first_level.children.each do |cat| 
            values[ITEM_CATEGORY]=cat.content if cat.name == ITEM_CATEGORY
          end
        end
        if first_level.name == PRICE
          first_level.children.each do |cat| 
            if cat.name == DISPLAY_PRICE
              display_price = cat.content.split(' ')
              values[CURRENCY]=display_price[1]
              values[PRICE]=display_price[0]
            end
          end
        end
        if first_level.name == DEEP_LINKS
          first_level.children.each do |cat| 
            values[DEEP_LINKS]=cat.content if cat.name == ITEM_ROOT
          end
        end
        if first_level.name == DETAILS
          first_level.children.each do |cat| 
            values[MANUFACTURER]=cat.content if cat.name == MANUFACTURER
            values[DESCRIPTION]=cat.content if cat.name == DESCRIPTION
            values[TITLE]=cat.content if cat.name == TITLE
          end
        end
        if first_level.name == IMAGES
          first_level.children.each do |cat| 
            values[IMAGES]=cat.content if cat.name == IMG
          end
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
          next if should_not_update(product, values)
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

      end
    end
  end



protected

  def should_not_update product, values
    product.name == product_name(values) || product_remote_image(values).blank?
  end 

  def children_from_tag parents, name
    collect = []
    for parent in parents
      parent.children.each do |child|
        if child.name == name
          collect << child 
        end
      end
    end
    collect
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