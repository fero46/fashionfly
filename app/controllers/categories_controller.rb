# frozen_string_literal: true
class CategoriesController < ScopeController
  before_action :set_per_param

  def index
    @products = ProductSearchService.new(@scope, params).products
    @categories = @category_group
  end

  def show
    @category = @scope.categories.where(slug: params[:id]).first
    @category_group = category_select(@category, true)
    @main_category  = category_select(@category)
    if @category.present?
      params[:category] = @category.id
      pss = ProductSearchService.new(@scope, params)
      @products = pss.products
      @title = pss.index_title(@category)
    else
      @products = Product.none.page
    end
  end

  protected

  def category_select(category, group = false)
    return nil if category.blank? || category.main_taxon && !group
      
     category.main_taxon && group
      category
    else
      result = category_select(category.category, group)
      result || category
    
  end

  def set_per_param
    params[:per] = 12 if params[:per].blank?
  end
end
