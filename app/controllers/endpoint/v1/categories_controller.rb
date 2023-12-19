# frozen_string_literal: true

module Endpoint
  module V1
    class CategoriesController < Endpoint::V1::ScopesController
      before_action :find_scope

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
  end
end
