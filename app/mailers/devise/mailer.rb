if defined?(ActionMailer)
  class Devise::Mailer < Devise.parent_mailer.constantize
    include Devise::Mailers::Helpers

    def confirmation_instructions(record, token, opts={})
      @token = token
      locale = record.try(:scope).try(:locale)
      locale = 'en' if locale.blank?
      I18n.with_locale(locale) do
        devise_mail(record, :confirmation_instructions, opts)
      end
    end

    def reset_password_instructions(record, token, opts={})
      @token = token
      locale = record.try(:scope).try(:locale)
      locale = 'en' if locale.blank?
      I18n.with_locale(locale) do
       devise_mail(record, :reset_password_instructions, opts)
      end
    end

    def unlock_instructions(record, token, opts={})
      @token = token
      locale = record.try(:scope).try(:locale)
      locale = 'en' if locale.blank?
      I18n.with_locale(locale) do
        devise_mail(record, :unlock_instructions, opts)
      end
    end
  end
end