class LanguageController < ApplicationController

  def select
    redirect_to root_path(locale: select_locale)
  end


end
