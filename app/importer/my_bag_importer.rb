class MyBagImporter < WConceptImporter

  def category_identifier
    ['merchant_category', 'category_name', 'custom_1', 'custom_2', 'custom_3']
  end

  def category_name node
    cat = super(node)
    value_custom_2 = nil
    value_custom_3 = nil
    node.children.each do |child|
      value_custom_2 = child.content if child.name == 'custom_2'
      value_custom_3 = child.content if child.name == 'custom_3'
    end

    if value_custom_2.present? && value_custom_2 ==value_custom_3
      if cat.present?
        cat = cat.gsub(value_custom_3, '')
        cat+=" #{value_custom_3}"
      end
    end

    return cat
  end

end