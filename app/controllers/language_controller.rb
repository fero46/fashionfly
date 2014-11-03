class LanguageController < ApplicationController

  def select
    redirect_to root_path(locale: select_locale)
  end


protected
  def select_locale
    code = Geocoder.search(request_ip).try(:first).try(:country_code)
    scope = nil
    scope = Scope.where(country_code: code).first if code.present?
    if scope.blank?
      ::Configuration.where(key: 'default_country_code').first.value
    else
      scope.locale
    end
  end


end
