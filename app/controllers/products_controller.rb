# frozen_string_literal: true
class ProductsController < ScopeController
  skip_before_action :verify_authenticity_token

  before_action :find_product, only: %i[show clicked]


  def index
    @products = ProductSearchService.new(@scope, params).products
  end

  def show
    @show_popup_link = false
  end

  def clicked
    @show_popup_link = true
    render 'show'
  end

  def ref
    
      @product = Product.find(params[:id])
      if @product.deepLink.blank?
        redirect_to root_path(@scope)
      else
        visit_me @product
        redirect_to @product.deepLink
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = I18n.t('action.product_not_found')
      redirect_to root_path(assigned_locale)
    
  end

  def refshop
    @product = Product.where(id: params[:product_id]).first
    if @product.blank? || @product.deepLink.blank?
      redirect_to root_path(@scope)
    else
      visit_me @product
      redirect_to @product.deepLink
    end
  end


  protected

  def find_product
    
      @product = Product.find(params[:id])
      if @product.try(:scope).try(:id) != @scope.try(:id)
        redirect_to product_path(@product.try(:scope).locale, @product)
      end
      @category = @product.categories.where(leaf: true).first
      if @product.removed
        if @category.present?
          redirect_to(category_path(assigned_locale, @category.slug), alert: I18n.t('action.product_not_found'))
        else
          redirect_to(root_path(assigned_locale), alert: I18n.t('action.product_not_found'))
        end
        return
      end
      @category_group = category_select(@category, true)
      @main_category  = category_select(@category)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = I18n.t('action.product_not_found')
      redirect_to root_path(assigned_locale)
    
  end

  def category_select(category, group = false)
    return nil if category.blank? || category.main_taxon && !group
      
     category.main_taxon && group
      category
    else
      result = category_select(category.category, group)
      result || category
    
  end

end
