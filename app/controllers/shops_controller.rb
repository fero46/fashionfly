class ShopsController < ScopeController

  before_action :find_shop, only: [:show, :edit, :update, :destroy, :ref]
  load_and_authorize_resource param_method: :shop_attributes

  def index
    @shops = @scope.shops
  end

  def list
    @shops = @scope.shops    
  end

  def ref
    redirect_to @shop.link
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_attributes)
    @shop.scope_id = @scope.id
    if @shop.save
      flash[:notice] = t('action.created', entity: Shop.model_name.human) 
      redirect_to shoplist_path(assigned_locale)
    else
      flash.now[:alert] = t('action.error')
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @shop.update(shop_attributes)
      flash[:notice] = t('action.updated', entity: Shop.model_name.human)
      redirect_to shoplist_path(assigned_locale)
    else
      flash.now[:alert] = t('action.error')
      render 'edit'
    end
  end

  def destroy
    @shop.destroy if @shop.present?
    flash[:notice] = t('action.destroyed', entity: Shop.model_name.human)
    redirect_to shoplist_path(assigned_locale)
  end

protected

  def find_shop
    @shop = Shop.find(params[:id]) 
  end

  def shop_attributes
    params.require(:shop).permit(:name,
                                 :logo,
                                 :logo_cache,
                                 :body,
                                 :link,
                                 :position,
                                 :sidebar_banner,
                                 :top_banner,
                                 :bottom_banner)
  end

end
