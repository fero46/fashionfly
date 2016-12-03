class BrandetCategoriesController < ScopeController

  before_action :set_per_param


  def show
    @brandet_categories = true
    @current_year = Time.new.year
    brand_slug = params[:brand]
    @brand = Brand.where(slug: brand_slug).first
    if @brand.present?
      category_slug = params[:category]
      @category = Category.where(slug: category_slug).first
      if @category.present?
        params[:brand] = @brand.id
        params[:category] = @category.id
        @products = ProductSearchService.new(@scope, params).products
      else
        redirect_to root_path
        return
      end
    else
      redirect_to root_path
      return
    end
  end


  def set_per_param
    params[:per] = 12 if params[:per].blank?
  end

end
