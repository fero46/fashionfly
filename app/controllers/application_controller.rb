class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :find_scope
  before_action :cookie_store
  before_action :check_favorite


  helper_method :get_right_scope, :locale_cookie, :assigned_locale, :cookie_store, :mycookies

  def self.assign_collection collection, controller, options={}
    return if collection.class.name != FashionFlyEditor::Collection.name || collection.new_record?
    if options[:scope].present?
      myscope = Scope.find(options["scope"])
      myscope.collections << collection
      puts options.to_yaml
      myscope.add_to_contest(collection) if options["contest"].to_s == 'true'
    end

    for collection_item in collection.collection_items
      product = nil
      product = Product.where(id: collection_item.item_id).first if collection_item.item_id.present?
      product.collections << collection if product.present?
    end
    user = User.where(secret: options["user"]).first if options[:user].present?
    if user.present?
      collection.user_id = user.id
      collection.published=true
      controller.cookie_access_hook[:collection] = nil
    else
      collection.published=false
      controller.cookie_access_hook[:collection] = collection.id
    end
    collection.save
  end

  def mycookies
    cookies
  end

  def self.facebook_button url
    locale = url.gsub!('/combine/', "").gsub!("/", "")
    scope = Scope.where(locale: locale).first
    if scope.present? &&  scope.facebook.present?
      '<div class="fb-like-box" data-href="'+scope.facebook+'" data-colorscheme="light" data-show-faces="false" data-header="false" data-stream="false" data-show-border="false"></div>'
    else
      ""
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url(locale: assigned_locale, :alert => exception.message)
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
    devise_parameter_sanitizer.for(:sign_up) << :name
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
    collection = FashionFlyEditor::Collection.where(id: cookies[:collection]).first if cookies[:collection].present?
    if collection.present?
      collection.user_id = current_user.id
      collection.published = true
      cookies[:collection] = nil
      collection.save
      collection_path(collection.scope.locale, collection)
    else
      root_path(assigned_locale)
    end
  end

  def assigned_locale
    return @locale if @locale.present?
    @locale = get_right_scope.locale if @locale.blank?
    set_locale_cookie @locale
    return @locale
  end


  def find_scope
    @scope = Scope.where(locale: assigned_locale).first
    I18n.locale = @scope.language if @scope.present?
  end

end
