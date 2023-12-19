# frozen_string_literal: true

class EntriesController < ApplicationController
  def index
    @entries = @scope.entries.page(params[:page]).per(params[:per].present? ? params[:per] : 20)
  end

  def show
    @entry = @scope.entries.find(params[:id])
  rescue StandardError
    redirect_to root_path
  end
end
