module OutfitCategoriesHelper

  def outfit_category_groups
    @outfit_category_groups ||= scope.child_outfit_categories
  end

  def create_outfit_categories category_group
    if category_group.present?
      category_group.categories
    else
      outfit_category_groups
    end
  end

  
end
