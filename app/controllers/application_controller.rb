class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :cookie_store
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
    cookies[:cookie_store] = (0...50).map { ('a'..'z').to_a[rand(26)] }.join if cookies[:cookie_store].blank?
  end

end
