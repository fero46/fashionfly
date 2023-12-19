# frozen_string_literal: true

class CollectionsController < ScopeController
  before_action :check_collection, only: :show

  def index
    @outfit_category = true
    @collections = CollectionSearchService.new(@scope, params).collections
  end

  def show
    # Hack for some reason i got an alert user allready signed in notice
    # I think it is a timing issue. Check Collection is called before the call back
    # assign_collection saved the collection to the user
    flash.delete(:alert)
    visit_me @collection
  end

  def check_collection
    @collection = FashionFlyEditor::Collection.find(params[:id])
    if @collection.blank?
      flash[:alert] = I18n.t('action.collection_not_found')
      redirect_to collections_path(@scope.locale)
    end
    return unless @collection.present? && @collection.published == false

    if cookies[:collection].present? && cookies[:collection].to_i == @collection.id
      flash[:alert] = I18n.t('action.required_to_signed_in')
      redirect_to new_user_session_path(locale: assigned_locale)
    else
      flash[:alert] = I18n.t('action.collection_not_found')
      redirect_to collections_path(@scope.locale)
    end
  end
end
