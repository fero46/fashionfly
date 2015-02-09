class EntriesController < ApplicationController

  def show
    @entry = @scope.entries.find(params[:id])
  end
end
