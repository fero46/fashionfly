class BrandsController < ScopeController

  def index
    @brands = Brand.page(params[:page]).per(params[:per].present? ? params[:per] : 10)
  end

  def show
    @brand = Brand.where(slug: params[:id]).first
    @categories = @scope.categories.page(params[:page]).per(params[:per].present? ? params[:per] : 102)
  end

end
