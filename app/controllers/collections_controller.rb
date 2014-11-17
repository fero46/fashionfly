class CollectionsController < ApplicationController
  def index
    @outfit_category = true
    @collections = CollectionSearchService.new(@scope, params).collections
  end

  def show
    @collection = FashionFlyEditor::Collection.find(params[:id])
  end
end
