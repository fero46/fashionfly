# frozen_string_literal: true

module Endpoint
  module V1
    class ProductsController < Endpoint::V1::ScopesController
      before_action :find_scope

      def index
        pss = ProductSearchService.new(@scope, params)
        @products = pss.products
      end

      def show
        @with_extra_info = true
        @product = @scope.products.find(params[:id])
      end
    end
  end
end
