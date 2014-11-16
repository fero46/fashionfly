module Backend::OutfitCategoriesHelper

  def filter_main_outfit_categories categories
    @main_taxon ||= categories.map{|c| c if c.parent_type == 'Scope' && c.parent_id == @scope.id}.compact
  end

  def filter_child_outfit_categories categories, category
    outfit_categoy_cache[category.id] ||= categories.map{|c| c if c.parent_type == 'FashionFlyEditor::Category' && c.parent_id == category.id}.compact
  end


  def icon_categories
    @icons ||= Icon.all
  end

  def outfit_categoy_cache
    @outfit_categoy_cache ||={}
  end

end
