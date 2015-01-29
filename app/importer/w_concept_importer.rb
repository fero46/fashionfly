class WConceptImporter < CsvToXmlAffiliateWindowImporter

  def category_identifier
    ['merchant_category', 'category_name', 'custom_1']
  end

  def category_name node
    category_name = ""
    node.children.each do |child|
      category_identifier.each do |identifier|
        category_name+= child.content + " " if child.name == identifier
      end
    end

    text = ""
    node.children.each do |child|
      text+= child.content + " " if child.name == DESCRIPTION_TAG
      text+= child.content + " " if child.name == NAME_TAG
    end
    text = text.strip.downcase

    found_posible_category = nil
    for category in affiliate_categories
      next if found_posible_category.present?
      found_posible_category = category if text.include? category.name.downcase
    end

    category_name+= found_posible_category.name if found_posible_category.present?
    category_name.gsub('Apparel & Accessories >', '').strip
  end

  def affiliate_categories
    @aff_categories ||=@scope.categories.where(leaf: true)
  end

end