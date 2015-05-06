class Endpoint::V1::CollectionsController < Endpoint::V1::ScopesController

  before_filter :find_scope
  before_filter :find_collection, only: :show

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