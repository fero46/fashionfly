# frozen_string_literal: true

module Backend
  class ScopesController < Backend::BackendController
    before_action :find_scope, only: %i[show edit update destroy]

    def index
      @scopes = Scope.all
    end

    def show; end

    def new
      @scope = Scope.new
    end

    def create
      @scope = Scope.new(scope_attributes)
      if @scope.save
        flash[:notice] = 'Speichern Erfolgreich'
        redirect_to backend_scope_path(@scope)
      else
        flash.now[:error] = 'Konnte nicht Speichern'
        render 'new'
      end
    end

    def edit; end

    def update
      if @scope.update(scope_attributes)
        flash[:notice] = 'Änderungen Erfolgreich'
        redirect_to backend_scope_path(@scope)
      else
        flash.now[:error] = 'Konnte nicht Speichern'
        render 'edit'
      end
    end

    def destroy
      @scope.destroy
      redirect_to backend_scopes_path
    end

    protected

    def find_scope
      @scope = Scope.find(params[:id])
    end

    def scope_attributes
      params.require(:scope).permit(:country_code,
                                    :locale,
                                    :language,
                                    :region_code,
                                    :facebook,
                                    :twitter,
                                    :google,
                                    :pinterest,
                                    :instagram,
                                    :youtube,
                                    :published,
                                    :meta_keywords,
                                    :meta_description,
                                    :hidden)
    end
  end
end
