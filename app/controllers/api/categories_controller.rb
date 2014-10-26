class Api::CategoriesController < Api::ApiController

  def index
    @categories = @scope.categories.where(main_taxon: true) 
  end


  def show
    @category = @scope.categories.where(id: params[:id]).first
  end

end
