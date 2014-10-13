class LanguageController < ApplicationController

  def select
    redirect_to root_path(locale: select_locale)
  end

protected 

  def request_ip
    if Rails.env.development? 
      params[:ip] ? params[:ip] : "80.203.37.20" # "85.177.133.79"
    else
      request.remote_ip
    end
  end

  def select_locale
    code = Geocoder.search(request_ip).first.country_code
    scope = Scope.where(country_code: code).first
    if scope.blank?
      ::Configuration.where(key: 'default_country_code').first.value
    else
      scope.locale
    end
  end

end
