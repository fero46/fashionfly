class Endpoint::V1::ScopesController < Endpoint::V1::BaseController

  before_action :find_scope, only: [:show]

  def index
    @scopes = Scope.all
  end

  def show
  end


protected

  def find_scope
    scope_id = params[:scope_id] || params[:id]
    @scope = Scope.find(scope_id)
  end

end
