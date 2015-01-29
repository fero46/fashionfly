
class AffiliateWindowImporter < AffilinetImporter
  require "erb"
  include ERB::Util
  
  ITEM_ROOT = 'merchant'
  ITEM = 'prod'
  MAIN_CAT = 'awCat'
  SUB_CAT = 'mCat'
  CAT = 'cat'
  PRICATE_TAG = 'price'
  PRICE_VALUE_TAG = 'buynow'
  P_ID = 'pId'
  IMAGE_TAG = 'mImage'
  TRACK_TAG = 'awTrack'
  MERCHANT_LINK = 'mLink'
  DEEP_LINKING = 'awLink'
  CURRENCY_TAG = 'curr'

  def categories
    nodes = children_from_tag [document.root], ITEM_ROOT
    nodes = children_from_tag [nodes.first], ITEM
    nodes.map{|i| category_name(i)}.uniq.sort 
  end


  def category_name node
    cat = ''
    node.children.each do |child|
      if child.name == CAT
        child.children.each do |cati|
          cat+=cati.content + ' ' if cati.name == MAIN_CAT || cati.name == SUB_CAT
        end
        puts cat
        return cat
      end
    end
    cat.strip
  end

  def import
    nodes = children_from_tag [document.root], ITEM_ROOT

    nodes.first.attributes.each do |a|
      default_brand_name = a.value if a.name == 'name'
    end

    nodes = children_from_tag [nodes.first], ITEM
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

      node.children.each do |first_level|
        id = get_id(first_level)
        check_price(first_level, values)
        check_deeplinks(first_level, values)
        check_details(first_level, values)
      end

      values[NUMBER] = id

      puts values

    end
    @affiliate.products.where(dirty: true).update_all(published: false)
    @affiliate.products.where(dirty: true).update_all(dirty: false)    
    @affiliate.skip_items = 0
    @affiliate.percent = 100
    @affiliate.save
    true
  end

  def check_details node, values

  end

  def check_deeplinks node, values
    awTrack=nil
    mLink=nil
    ref = 'http://fashionfly.co/'
    node.children.each do |child|
      name = child.name.to_s
      content = child.content
      next if name == 'text'
      values[IMAGES]=content if name== self.class::IMAGE_TAG
      values[DEEP_LINKS]=content if name == self.class::DEEP_LINKING
      awTrack=content if name == self.class::TRACK_TAG
      mLink=content if name == self.class::MERCHANT_LINK
    end
    if values[DEEP_LINKS].blank? && mLink.present?
      clean_ref = url_encode(ref)
      clean_mLink=url_encode(mLink)
      values[DEEP_LINKS] = "http://www.awin1.com/cread.php?awinmid=6016&awinaffid=226653&clickref=#{clean_ref}&p=#{clean_mLink}"
    elsif values[DEEP_LINKS].blank?
      raise 'ERROR KEIN DEEP LINK'
    end
    values[DEEP_LINKS]
  end

  def get_id node
    return node.content if node.name == self.class::P_ID
  end

  def check_price node, values
    if node.name == self.class::PRICATE_TAG
      node.attributes.each do |a|
        values[CURRENCY] = a.value if a.name == self.class::CURRENCY_TAG
      end
      node.children.each do |cat| 
        values[PRICE]=cat.contentif cat.name == self.class::PRICE_VALUE_TAG
      end
    end
  end

  def check_category_node node, values
    values[ITEM_CATEGORY] = category_name node
  end


end