class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment
  belongs_to :commentable, :polymorphic => true, :touch => true
  default_scope -> { order('created_at DESC') }
  belongs_to :user

  after_create :notify_owner

  def notify_owner
    if self.commentable_type == 'FashionFlyEditor::Collection'
      CommentMailer.collection(self.id).deliver_later  if commentable.user_id != self.user_id
    end 
  end

end
