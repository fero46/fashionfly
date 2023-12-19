# frozen_string_literal: true

if defined?(ActionMailer)
  module Devise
    class Mailer < Devise.parent_mailer.constantize
      include Devise::Mailers::Helpers

      def confirmation_instructions(record, token, opts = {})
        @token = token
        locale = record.try(:scope).try(:language)
        locale = 'en' if locale.blank?
        I18n.with_locale(locale) do
          devise_mail(record, :confirmation_instructions, opts)
        end
      end

      def reset_password_instructions(record, token, opts = {})
        @token = token
        locale = record.try(:scope).try(:language)
        locale = 'en' if locale.blank?
        I18n.with_locale(locale) do
          devise_mail(record, :reset_password_instructions, opts)
        end
      end

      def unlock_instructions(record, token, opts = {})
        @token = token
        locale = record.try(:scope).try(:language)
        locale = 'en' if locale.blank?
        I18n.with_locale(locale) do
          devise_mail(record, :unlock_instructions, opts)
        end
      end
    end
  end
end
