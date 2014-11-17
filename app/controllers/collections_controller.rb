class CollectionsController < ScopeController
  before_action :check_collection, only: :show

  def index
    @outfit_category = true
    @collections = CollectionSearchService.new(@scope, params).collections
  end

  def show
  end

  def check_collection
    @collection = FashionFlyEditor::Collection.find(params[:id])
    if @collection.blank?
      flash[:alert] = I18n.t('action.collection_not_found')
      redirect_to collections_path(@scope.locale)
    end
    if @collection.present? && @collection.published == false
      if cookies[:collection].present? && cookies[:collection].to_i == @collection.id
        flash[:alert] = I18n.t('action.required_to_signed_in')
        redirect_to new_user_session_path(locale:assigned_locale)
      else
        flash[:alert] = I18n.t('action.collection_not_found')
        redirect_to collections_path(@scope.locale)        
      end
    end
  end

end
