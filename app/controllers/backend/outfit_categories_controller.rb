# frozen_string_literal: true

module Backend
  class OutfitCategoriesController < Backend::BackendController
    before_action :find_scope
    respond_to :json

    def index
      @categories = @scope.outfit_categories
    end

    def create
      @category = FashionFlyEditor::Category.new(category_attributes)
      if @category.save
        flash[:notice] = 'Erfolgreich gespeichert'
      else
        flash[:error] = 'Nicht gespeichert'
      end
      redirect_to backend_scope_outfit_categories_path(@scope)
    end

    def update
      @category = FashionFlyEditor::Category.find(params[:id])
      if @category.update(category_attributes)
        flash[:notice] = 'Erfolgreich aktualisiert'
      else
        flash[:error] = 'Änderungen nicht gespeichert'
      end
      redirect_to backend_scope_outfit_categories_path(@scope)
    end

    def destroy
      @scope.outfit_categories.where(id: params[:id]).first.try(:destroy)
      redirect_to backend_scope_outfit_categories_path(@scope)
    end

    protected

    def find_scope
      @scope = Scope.find(params[:scope_id])
    end

    def category_attributes
      params.require('fashion_fly_editor_category').permit(:name,
                                                           :parent,
                                                           :parent_id,
                                                           :parent_type,
                                                           :scope_id,
                                                           :position)
    end
  end
end
