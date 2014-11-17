class OutfitCategoriesController < ApplicationController

  def index
    @outfit_category = true
    @collections = CollectionSearchService.new(@scope, params).collections
  end

  def show
    @category=@scope.outfit_categories.where(slug: params[:id]).first
    @outfit_category = true
    @category_group = category_select(@category, true)
    @main_category  = category_select(@category)
    if @category.present?
      params[:outfit_category] = @category.id
      @collections = CollectionSearchService.new(@scope, params).collections    
    else
      @collections = FashionFlyEditor::Collection.none.page()
    end    
  end

private

  def category_select category, group = false
    if category.blank? || category.parent.class.name == 'Scope' && !group
      return nil
    elsif category.parent.class.name == 'Scope' && group
      return category
    else
      result = category_select(category.parent,group)
      return result ? result : category
    end
  end

  def set_per_param
    params[:per] = 12 if params[:per].blank?
  end
end
