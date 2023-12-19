# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def after_sign_up_path_for(resource)
      after_inactive_sign_up_path_for(resource)
    end

    def after_inactive_sign_up_path_for(resource)
      flash[:notice] = t('action.confirmation_send', mail: resource.unconfirmed_email)
      root_path(locale: assigned_locale)
    end
  end
end
