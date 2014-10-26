class Api::ApiController < ApplicationController
  respond_to :json

  before_filter :check_format
  before_filter :find_scope


  def check_format
    render :nothing => true, :status => 406 unless params[:format] == 'json' || request.headers["Accept"] =~ /json/
  end

  def find_scope
    @scope = Scope.where(locale: params[:locale]).first
  end

end
