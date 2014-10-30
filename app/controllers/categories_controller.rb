class CategoriesController < ScopeController

  def index
    @products = ProductSearchService.new(@scope, params).products
  end

  def show
    @category = @scope.categories.where(slug: params[:id]).first
    @category_group = category_select(@category, true)
    @main_category  = category_select(@category)  
    if @category.present?
      params[:category] = @category.id
      @products = ProductSearchService.new(@scope, params).products
    else
      @products = Product.none.page()
    end
  end

protected

  def category_select category, group = false
    if category.blank? || category.main_taxon && !group
      return nil
    elsif category.main_taxon && group
      return category
    else
      result = category_select(category.category,group)
      return result ? result : category
    end
  end

end
