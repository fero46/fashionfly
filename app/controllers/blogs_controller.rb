# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  before_action :find_user, only: %i[edit update]

  def edit; end

  def update
    @user.update(blog_attributes)
    redirect_to edit_profile_blog_path(@user.scope.locale, @user.slug)
  end

  def show
    @user = User.where(slug: params[:profile_id]).first
    redirect_to profile_path(@scope.locale, params[:profile_id]) if @user.is_blogger.blank?
    @entries = @user.try(:feed).try(:entries).page(params[:page]).per(params[:per].present? ? params[:per] : 20)
  end

  private

  def blogger_attributes; end

  def find_user
    @user = if current_user.is_admin?
              User.where(slug: params[:profile_id]).first
            else
              current_user
            end
  end

  def blog_attributes
    if current_user.is_admin?
      params.require(:user).permit(:blog_title,
                                   :blog_url,
                                   :blog_feed,
                                   :blog_apply,
                                   :blog_status)
    else
      params.require(:user).permit(:blog_title,
                                   :blog_url,
                                   :blog_feed,
                                   :blog_apply)
    end
  end
end
