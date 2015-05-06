class Endpoint::V1::ProductsController < Endpoint::V1::ScopesController

  before_filter :find_scope

  def index
    pss = ProductSearchService.new(@scope, params)
    @products = pss.products
  end

  def show
    @with_extra_info = true
    @product = @scope.products.find(params[:id])
  end

end