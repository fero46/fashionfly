# frozen_string_literal: true

class CommentsController < ScopeController
  before_action :authenticate_user!
  before_action :find_collection

  def create
    @comment = @collection.comments.build(comments_attribute)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = t('action.created', entity: Comment.model_name.human)
    else
      flash[:alert] = t('action.error')
    end
    redirect_to collection_path(locale: @scope.locale, id: @collection.id)
  end

  def update
    @comment = current_user.comments.where(id: params[:id]).first
    if @comment.update(comments_attribute)
      flash[:notice] = t('action.updated', entity: Comment.model_name.human)
    else
      flash[:alert] = t('action.error')
    end
    redirect_to collection_path(locale: @scope.locale, id: @collection.id)
  end

  def destroy
    @comment = current_user.comments.where(id: params[:id]).first
    @comment.destroy
    redirect_to collection_path(locale: @scope.locale, id: @collection.id)
  end

  protected

  def comments_attribute
    params.require(:comment).permit(:comment)
  end

  def find_collection
    @collection = @scope.collections.where(id: params[:collection_id]).first
    return unless @collection.blank?

    redirect_to root_path(locale: @scope.locale)
  end
end
