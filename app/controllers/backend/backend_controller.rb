class Backend::BackendController < ApplicationController
  layout 'backend'


  def get_right_scope
  end

  def assigned_locale
    'de'
  end
end