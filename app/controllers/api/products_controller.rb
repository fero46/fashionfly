class Api::ProductsController < Api::ApiController

  def index
    @products = ProductSearchService.new(@scope, params).products
  end

end
