class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :find_scope

  before_action :cookie_store
  before_action :check_favorite

  helper_method :get_right_scope, :locale_cookie, :assigned_locale, :cookie_store

  def self.assign_collection collection, options={}
    return if collection.class.name != FashionFlyEditor::Collection.name || collection.new_record?
    if options[:scope].present?
      myscope = Scope.find(options[:scope])
      myscope.subscriptions.create(collection_id: collection.id)
      myscope.add_to_contest(collection) if options[:contest]
    end
    collection.published=true
    collection.save
  end

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
    cookies[:cookie_store] = (0...30).map { ('a'..'z').to_a[rand(26)] }.join if current_user.blank? && cookies[:cookie_store].blank? 
    cookies[:cookie_store]
  end

  def check_favorite
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
    locale = params[:locale] 
    locale = locale_cookie if locale.blank?
    @scope = Scope.where(locale: locale).first if locale.present?
    if @scope.blank?
      code = Geocoder.search(request_ip).try(:first).try(:country_code)
      @scope = Scope.where(country_code: code).first if code.present?
    end
    if @scope.blank?
      @scope = Scope.where(country_code: ::Configuration.where(key: 'default_country_code').first.value).first
    end
    @scope
  end

  def locale_cookie
    cookies[:locale_cookie]
  end

  def set_locale_cookie locale=params[:locale]
    cookies[:locale_cookie] = locale if locale.present?
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path(assigned_locale)
  end

  def after_sign_in_path_for(resource_or_scope)
    root_path(assigned_locale)
  end

  def assigned_locale
    return @locale if @locale.present?
    @locale = get_right_scope.locale if @locale.blank?
    set_locale_cookie @locale
    return @locale
  end


  def find_scope
    @scope = Scope.where(locale: assigned_locale).first
    I18n.locale = @scope.locale if @scope.present?
  end

end
