module OutfitCategoriesHelper

  def outfit_category_groups
    @outfit_category_groups ||= scope.child_outfit_categories
  end
  
end
