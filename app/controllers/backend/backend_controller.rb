class Backend::BackendController < ApplicationController
  layout 'backend'

  before_action :authenticate_user!
  before_action :has_access


  def get_right_scope
  end

  def assigned_locale
    'de'
  end

private

  def has_access
    unless current_user.is_admin?
      redirect_to root_path(assigned_locale)
    end
  end
end