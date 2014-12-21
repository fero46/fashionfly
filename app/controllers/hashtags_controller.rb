class HashtagsController < ScopeController

  def index
    @hashtags = @scope.hashtags.page(params[:page]).per(30)
  end

  def show
    @hashtag = @scope.hashtags.where(name: params[:hashtag]).first
    @hashtagged = @hashtag.hashtaggings.page(params[:page]).per(32) if @hashtag
  end

end
