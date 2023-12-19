# frozen_string_literal: true

module Endpoint
  module V1
    class CollectionsController < Endpoint::V1::ScopesController
      before_action :find_scope
      before_action :find_collection, only: :show

      def index
        @collections = CollectionSearchService.new(@scope, params).collections
      end

      def show
        @with_extra_info = true
      end

      protected

      def find_collection
        collection_id = params[:collection_id] || params[:id]
        @collection = @scope.collections.find(collection_id)
      end
    end
  end
end
