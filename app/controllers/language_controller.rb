# frozen_string_literal: true

class LanguageController < ApplicationController
  def select
    redirect_to root_path(locale: select_locale)
  end

  protected

  def select_locale
    get_right_scope.locale
  end
end
