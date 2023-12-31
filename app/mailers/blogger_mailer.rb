# frozen_string_literal: true

class BloggerMailer < ApplicationMailer
  def apply(user_id)
    @user = User.find(user_id)
    I18n.with_locale('de') do
      mail(to: 'service@fashionfly.co', subject: t('blogger_mailer.apply.subject'))
    end
  end

  def information(user_id)
    @user = User.find(user_id)
    return unless @user.present?

    @locale = @user.try(:scope).try(:language)
    @locale = 'en' if locale.blank?
    I18n.with_locale(@locale) do
      mail(to: @user.email, subject: t('blogger_mailer.default.subject'))
    end
  end

  def accept(user_id)
    @user = User.find(user_id)
    return unless @user.present?

    @locale = @user.try(:scope).try(:language)
    @locale = 'en' if locale.blank?
    I18n.with_locale(@locale) do
      mail(to: @user.email, subject: t('blogger_mailer.default.subject'))
    end
  end

  def denied(user_id)
    @user = User.find(user_id)
    return unless @user.present?

    @locale = @user.try(:scope).try(:language)
    @locale = 'en' if locale.blank?
    I18n.with_locale(@locale) do
      mail(to: @user.email, subject: t('blogger_mailer.default.subject'))
    end
  end
end
