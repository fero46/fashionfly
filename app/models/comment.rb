# frozen_string_literal: true

class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment
  belongs_to :commentable, polymorphic: true, touch: true
  default_scope -> { order('created_at DESC') }
  belongs_to :user

  after_create :notify_owner

  def notify_owner
    return unless commentable_type == 'FashionFlyEditor::Collection'

    CommentMailer.collection(id).deliver_later if commentable.user_id != user_id
  end
end
