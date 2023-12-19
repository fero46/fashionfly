# frozen_string_literal: true

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
        redirect_to category_path(assigned_locale, @category.slug)
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
    nil
  end

  def set_per_param
    params[:per] = 12 if params[:per].blank?
  end
end
