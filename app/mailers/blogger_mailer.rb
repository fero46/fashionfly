class BloggerMailer < ApplicationMailer

  def apply user_id
    @user = User.find(user_id)
    I18n.with_locale('de') do
      mail(to: 'service@fashionfly.co' , subject: t('bloggger_mailer.apply.subject'))
    end
  end

  def accept user_id
    @user = User.find(user_id)
    if @user.present?
      @locale = @user.try(:scope).try(:locale)
      @locale = 'en' if locale.blank?
      I18n.with_locale(@locale) do
        mail(to: @user.email, subject: t('bloggger_mailer.accept.subject'))
      end
    end
  end

  def denied user_id
    @user = User.find(user_id)
    if @user.present?
      @locale = @user.try(:scope).try(:locale)
      @locale = 'en' if locale.blank?
      I18n.with_locale(@locale) do
        mail(to: @user.email, subject: t('bloggger_mailer.denied.subject'))
      end
    end
  end


end
