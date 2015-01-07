class Api::ProductsController < Api::ApiController

  def index
    @products = ProductSearchService.new(@scope, params).products(true)
  end

end
