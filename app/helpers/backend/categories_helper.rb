module Backend::CategoriesHelper

  def filter_main_categories categories
    @main_taxon ||= categories.map{|c| c if c.main_taxon}.compact
  end

  def filter_child_categories categories, category
    categoy_cache[category.id] ||= categories.map{|c| c if c.category_id == category.id}.compact
  end

  def is_parent_main_group? categories, category
    return parent_cache[category.id] if parent_cache[category.id].present?
    parent = categories.map{|c| c if c.id == category.category_id}.compact.first
    parent_cache[category.id] = parent.present? && parent.main_taxon
  end

  def icon_categories
    @icons ||= Icon.all
  end

  def categoy_cache
    @categoy_cache ||={}
  end

  def parent_cache
    @parent_cache ||={}
  end

end
