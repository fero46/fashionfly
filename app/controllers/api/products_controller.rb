# frozen_string_literal: true

module Api
  class ProductsController < Api::ApiController
    def index
      @products = ProductSearchService.new(@scope, params).products(true)
    end
  end
end
