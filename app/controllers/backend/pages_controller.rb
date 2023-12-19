# frozen_string_literal: true

module Backend
  class PagesController < Backend::BackendController
    before_action :find_scope
    before_action :find_page, only: %i[show edit update destroy]

    def index
      @pages = @scope.pages.page(params[:page]).per(10)
    end

    def new
      @page = @scope.pages.build
    end

    def show; end

    def create
      @page = @scope.pages.build(page_attributes)
      if @page.save
        flash[:notice] = 'Speichern Erfolgreich'
        redirect_to backend_scope_page_path(@scope, @page)
      else
        flash.now[:error] = 'Konnte nicht Speichern'
        render 'new'
      end
    end

    def edit; end

    def update
      if @page.update(page_attributes)
        flash[:notice] = 'Speichern Erfolgreich'
        redirect_to backend_scope_page_path(@scope, @page)
      else
        flash.now[:error] = 'Konnte nicht Speichern'
        render 'new'
      end
    end

    def destroy
      if @page.present?
        @page.destroy
        flash.now[:error] = 'Erfolgreich gelöscht'
      end
      redirect_to backend_scope_pages_path(@scope)
    end

    protected

    def find_page
      @page = Page.where(id: params[:id], scope_id: @scope.id).first
    end

    def find_scope
      @scope = Scope.find(params[:scope_id])
    end

    def page_attributes
      params.require(:page).permit(:title,
                                   :body,
                                   :name)
    end
  end
end
