class ScopeController < ApplicationController

  skip_before_action :get_right_scope
  before_action :find_scope

protected

  def find_scope
    @scope = Scope.where(locale: params[:locale]).first
    if has_access_to_scope @scope
      I18n.locale = @scope.language
    else
      alternative_scope = Scope.where(country_code: ::Configuration.where(key: 'default_country_code').first.value).first
      redirect_to root_path(locale: alternative_scope.locale)
    end
    current_user.update(scope_id: @scope.id) if current_user && current_user.scope_id != @scope.try(:id) && @scope.present?
    @scope = Scope.first if @scope.blank?
    @scope
  end

  def has_access_to_scope scope
    scope.present? && (
    scope.published ||
    scope.country_code.strip == ::Configuration.where(key: 'default_country_code').first.value.strip ||
    current_user && current_user.is_team?)
  end

  def visit_me visitable
    begin
      ua = AgentOrange::UserAgent.new(request.user_agent)
      device = ua.device
      return if device.is_bot?
      Visit.run(visitable, current_user, visitor_cookie)
      cookies[:visit_cookie] = nil if current_user.present?
    rescue
    end
  end

  def visitor_cookie
    if current_user.blank? && cookies[:visit_cookie].blank?
      cookies[:visit_cookie] = (0...30).map { ('a'..'z').to_a[rand(26)] }.join
    end
    cookies[:visit_cookie]
  end

end
