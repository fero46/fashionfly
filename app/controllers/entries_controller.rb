class EntriesController < ApplicationController

  def index
    @entries = @scope.entries.page(params[:page]).per(params[:per].present? ? params[:per] : 20)
  end

  def show
    begin
      @entry = @scope.entries.find(params[:id])
    rescue
      redirect_to root_path
    end
  end
end
