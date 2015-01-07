class GaleriaImporter < AffilinetImporter

  ITEM_PROPERTIES ='Properties'
  ITEM_PROPERTY = 'Property'
  GENDER = 'CF_gender'

  def categories
    nodes = children_from_tag [document.root], ITEM_ROOT
    result = []
    for node in nodes
      values = {}
      node.children.each do |first_level|
        check_category_node(first_level, values)
      end
      result << product_category(values)
    end
    result.uniq.sort
  end


protected

  def check_category_node(node, values)
    if node.name == ITEM_CATEGORY_PATH
      node.children.each do |cat| 
        values[ITEM_CATEGORY]=cat.content if cat.name == ITEM_CATEGORY
      end
    end
    if node.name == ITEM_PROPERTIES
      node.children.each do |property|
        if property.name == ITEM_PROPERTY
          title = ""
          text = ""
          property.attributes.each do |a|
            title = a.value if a.name == 'Title'
            text = a.value if a.name == 'Text'
          end 
          values[title] = text if title.present? && text.present?
        end
      end
    end
  end

  def product_category(values)
    "#{values[GENDER]} - #{values[ITEM_CATEGORY]}"
  end

  def should_not_update product, values
    return false
  end

end