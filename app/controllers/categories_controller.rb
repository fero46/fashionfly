class CategoriesController < ScopeController

  def index
    @products = ProductSearchService.new(@scope, params).products
  end

  def show
    @category = @scope.categories.where(slug: params[:id]).first
    if @category.present?
      params[:category] = @category.id
      @products = ProductSearchService.new(@scope, params).products
    else
      @products = Product.none.page()
    end
  end

end
