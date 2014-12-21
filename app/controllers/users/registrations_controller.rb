class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource)
    flash[:notice] = t('action.confirmation_send', mail: resource.email)
    root_path(locale: assigned_locale)
  end
end