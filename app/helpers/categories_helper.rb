# frozen_string_literal: true

module CategoriesHelper
  def category_groups
    @category_groups ||= scope.categories.where(main_taxon: true)
  end

  def create_categories(category_group)
    if category_group.present?
      category_group.categories
    else
      category_groups
    end
  end
end
