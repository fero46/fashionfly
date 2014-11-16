class FavoritesController < ApplicationController

  before_action :find_object

  def create
    status= "notsaved"
    store = current_user.blank? ? cookie_store : nil
    user_id = current_user.present? ? current_user.id : nil   
    if @object.present?
      @object.favorites.where(user_id: user_id, cookie_store: store).first_or_create
      status = 'saved'
    end
    render :json => { :status => status, params: params}
  end

  def destroy
    status= "notsaved"
    if @object.present?
      if current_user
        fav=@object.favorites.where(user_id: current_user.id).first
      else
        fav=@object.favorites.where(cookie_store: cookie_store).first
      end
      fav.destroy if fav.present?
      status = 'destroyed'
    end
    render :json => { :status => status}
  end

private

  def find_object
    if params[:product_id].present?
      @object = Product.find(params[:product_id])
    elsif params[:collection_id].present?
      @object = FashionFlyEditor::Collection.find(params[:collection_id])
    end
  end

end
