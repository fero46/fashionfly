class FavoritesController < ApplicationController

  def create
    product_id = params[:product_id]
    store = current_user.blank? ? cookie_store : nil
    user_id = current_user.present? ? current_user.id : nil
    Favorite.where(product_id: product_id, user_id: user_id, cookie_store: store).first_or_create
    render :json => { :status => "ok" }
  end

  def destroy
    if current_user
      fav = current_user.favorites
    else
      fav=Favorite.where(cookie_store: cookie_store)
    end
    fav = fav.where(product_id: params[:product_id]).first
    fav.destroy if fav.present?
    render :json => { :status => "ok" }
  end    

end
