# frozen_string_literal: true

class BannersController < ScopeController
  before_action :find_banner, only: %i[show edit update destroy]
  load_and_authorize_resource param_method: :banner_attributes

  def index
    @banners = @scope.banners
  end

  def show
    redirect_to @banner.link
  end

  def new
    @banner = Banner.new
  end

  def create
    @banner = Banner.new(banner_attributes)
    @banner.scope_id = @scope.id
    if @banner.save
      flash[:notice] = t('action.created', entity: Banner.model_name.human)
      redirect_to banners_path(assigned_locale)
    else
      flash.now[:alert] = t('action.error')
      render 'new'
    end
  end

  def edit; end

  def update
    if @banner.update(banner_attributes)
      flash[:notice] = t('action.updated', entity: Banner.model_name.human)
      redirect_to banners_path(assigned_locale)
    else
      flash.now[:alert] = t('action.error')
      render 'edit'
    end
  end

  def destroy
    @banner.destroy if @banner.present?
    flash[:notice] = t('action.destroyed', entity: Banner.model_name.human)
    redirect_to banners_path(assigned_locale)
  end

  protected

  def find_banner
    @banner = Banner.find(params[:id])
  end

  def banner_attributes
    params.require(:banner).permit(:name,
                                   :banner,
                                   :banner_cache,
                                   :link,
                                   :preview_ids,
                                   :previews_model,
                                   :position)
  end
end
