class CommentMailer < ApplicationMailer
  def collection comment_id
    comment = Comment.find(comment_id)
    @commenter = comment.user.name 
    @collection = comment.commentable
    @user = @collection.user
    if @user.present?
      @locale = @user.try(:scope).try(:locale)
      @locale = 'en' if locale.blank?
      I18n.with_locale(@locale) do
        mail(to: @user.email, subject: t('comment_mailer.collection.subject'))
      end
    end
  end
end
