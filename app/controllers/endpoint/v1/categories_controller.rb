class Endpoint::V1::CategoriesController < Endpoint::V1::ScopesController

  before_filter :find_scope

  def index
    @categories = @scope.categories
  end

  def show
    @category = @scope.categories.find(params[:id])
    params[:category_id] = @category.id
    pss = ProductSearchService.new(@scope, params)
    @products = pss.products
  end

end