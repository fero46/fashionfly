class CsvToXmlAffiliateWindowImporter < AffiliateWindowImporter

  ITEM_ROOT = 'product'
  ITEM = 'prod'
  MAIN_CAT = 'awCat'
  SUB_CAT = 'mCat'
  CAT = 'cat'
  PRICE_VALUE_TAG = 'search_price'
  P_ID = 'aw_product_id'
  IMAGE_TAG = 'merchant_image_url'
  TRACK_TAG = 'awTrack'
  MERCHANT_LINK = 'merchant_deep_link'
  DEEP_LINKING = 'awLink'
  CURRENCY_TAG = 'currency'
  BRAND_TAG = 'brand_name'
  DESCRIPTION_TAG = 'description'
  NAME_TAG = 'product_name'

  def categories
    nodes = document.root
    result = []
    for node in nodes
      cat = category_name(node)
      result << cat if cat.present?
    end
    result.uniq
  end


  def import
    nodes = children_from_tag [document.root], ITEM_ROOT
    total_counter = nodes.length
    actual_counter = 0
    @affiliate.products.update_all(dirty: true)
    for node in nodes
      actual_counter += 1
      if actual_counter % 20 == 0
          @affiliate.percent = ((actual_counter.to_f/total_counter.to_f).to_f * 100).to_i
          @affiliate.save
      end
      next if @affiliate.skip_items > actual_counter
      values = {}
      id = nil

      check_category_node(node, values)
      node.children.each {|n| next if id.present?; id = get_id(n)}
      check_price(node, values)
      check_deeplinks(node, values)
      check_details(node, values)

      values[NUMBER] = id
      insert_values id, values

      @affiliate.skip_items = actual_counter
      @affiliate.save
    end
    @affiliate.products.where(dirty: true).update_all(published: false)
    @affiliate.products.where(dirty: true).update_all(dirty: false)    
    @affiliate.skip_items = 0
    @affiliate.percent = 100
    @affiliate.save
    true
  end

  def check_price node, values
    node.children.each do |a|
      values[CURRENCY] = a.content if a.name == self.class::CURRENCY_TAG
      values[PRICE]=a.content  if a.name == self.class::PRICE_VALUE_TAG
    end
  end

  def check_details node, values
    node.children.each do |cat| 
      values[MANUFACTURER]=cat.content if cat.name == BRAND_TAG
      values[DESCRIPTION]=cat.content if cat.name == DESCRIPTION_TAG
      values[TITLE]=cat.content if cat.name == NAME_TAG
    end
  end


  def category_name node
    category_name = ""
    node.children.each do |child|
      category_identifier.each do |identifier|
        category_name+= child.content + " " if child.name == identifier
      end
    end
    category_name.strip
  end

  def category_identifier
    ['merchant_category', 'category_name']
  end

end