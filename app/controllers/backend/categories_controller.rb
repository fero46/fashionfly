class Backend::CategoriesController < Backend::BackendController
  before_action :find_scope
  respond_to :json

  def index
    @categories = @scope.categories.where(main_taxon: true)
  end

  def create
    @category = Category.new(category_attributes)
    if @category.save
      flash[:notice] = "Erfolgreich gespeichert"
    else
      flash[:error] = "Nicht gespeichert"  
    end 
    redirect_to backend_scope_categories_path(@scope)
  end

  def destroy
    @scope.categories.where(id: params[:id]).first.try(:destroy)
    redirect_to backend_scope_categories_path(@scope)
  end

protected

  def find_scope
    @scope = Scope.find(params[:scope_id])
  end

  def category_attributes
    params.require('category').permit(:name,
                                      :main_taxon,
                                      :scope_id,
                                      :category_id,
                                      :position)
  end


end
