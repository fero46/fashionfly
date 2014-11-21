class ProductsController < ScopeController
  def index
  end

  def show
    @product = Product.find(params[:id])
    @category = @product.categories.where(:leaf => true).first
    @category_group = category_select(@category, true)
    @main_category  = category_select(@category) 
  end


  def refshop
    @product = Product.where(id: params[:product_id]).first
    if @product.blank? || @product.deepLink.blank?
      redirect_to root_path(@scope)
    else
      redirect_to @product.deepLink
    end
  end


protected

  def category_select category, group = false
    if category.blank? || category.main_taxon && !group
      return nil
    elsif category.main_taxon && group
      return category
    else
      result = category_select(category.category,group)
      return result ? result : category
    end
  end


end
