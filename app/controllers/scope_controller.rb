class ScopeController < ApplicationController

  before_filter :find_scope

  def find_scope
    @scope = Scope.where(locale: params[:locale]).first
  end

end