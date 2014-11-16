class CollectionsController < ApplicationController
  def index
  end

  def show
    @collection = FashionFlyEditor::Collection.find(params[:id])
  end
end
