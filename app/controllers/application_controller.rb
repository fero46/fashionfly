class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :cookie_store
  before_action :set_locale_cookie
  before_action :check_favorite

  helper_method :get_right_scope, :locale_cookie, :assigned_locale, :cookie_store

protected 

  def request_ip
    if Rails.env.development? 
      params[:ip] ? params[:ip] : "80.203.37.20" # "85.177.133.79"
    else
      request.remote_ip
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

  def cookie_store
    cookies[:cookie_store] = (0...50).map { ('a'..'z').to_a[rand(26)] }.join if current_user.blank? && cookies[:cookie_store].blank?
    cookies[:cookie_store]
  end

  def check_favorite
    puts "Cookiestore #{cookie_store}"
    puts "Current_USER #{current_user}"

    if current_user.present? && cookie_store.present?
      myfavs = Favorite.where(user_id: nil).where(cookie_store: cookie_store)
      puts Favorite.where(user_id: nil).where(cookie_store: cookie_store).to_sql
      for fav in myfavs
        fav.user_id = current_user.id
        fav.cookie_store=nil
        fav.save
      end
      cookies[:cookie_store] == ""
    end
  end

  def get_right_scope
    return @scope if @scope.present?
    code = Geocoder.search(request_ip).try(:first).try(:country_code)
    scope = nil
    scope = Scope.where(country_code: code).first if code.present?
    scope = Scope.where(country_code: ::Configuration.where(key: 'default_country_code').first.value).first if scope.blank?
    @scope = scope
  end

  def locale_cookie
    cookies[:locale_cookie]
  end

  def set_locale_cookie
    cookies[:locale_cookie] = params[:locale] if params[:locale].present?
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path(assigned_locale)
  end

  def after_sign_in_path_for(resource_or_scope)
    root_path(assigned_locale)
  end

  def assigned_locale
    return @locale if @locale.present?
    @locale = params[:locale]
    @locale = locale_cookie if @locale.blank?
    @locale = get_right_scope.locale
  end


end
