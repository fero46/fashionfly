class ScopeController < ApplicationController

  skip_before_filter :get_right_scope
  before_filter :find_scope

protected

  def find_scope
    @scope = Scope.where(locale: params[:locale]).first
    I18n.locale = @scope.locale if @scope.present?
  end

end