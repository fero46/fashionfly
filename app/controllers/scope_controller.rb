class ScopeController < ApplicationController

  skip_before_filter :get_right_scope
  before_filter :find_scope

protected

  def find_scope
    @scope = Scope.where(locale: params[:locale]).first
    if has_access_to_scope @scope
      I18n.locale = @scope.locale 
    else
      alternative_scope = Scope.where(country_code: ::Configuration.where(key: 'default_country_code').first.value).first
      redirect_to root_path(locale: alternative_scope.locale)
    end
  end

  def has_access_to_scope scope
    scope.present? && (
    scope.published ||
    scope.country_code.strip == ::Configuration.where(key: 'default_country_code').first.value.strip ||
    current_user && current_user.is_team?)
  end

end