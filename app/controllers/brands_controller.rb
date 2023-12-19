# frozen_string_literal: true

class BrandsController < ScopeController
  def index
    @brands = Brand.page(params[:page]).per(params[:per].present? ? params[:per] : 102)
  end

  def show
    @brand = Brand.where(slug: params[:id]).first
    @categories = @scope.categories.page(params[:page]).per(params[:per].present? ? params[:per] : 102)
  end
end
