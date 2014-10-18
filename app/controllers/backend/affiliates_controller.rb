class Backend::AffiliatesController < Backend::BackendController

  before_action :find_scope

  def index
    @affiliates = Affiliate.where(scope_id: @scope.id)
  end


  def new
    @affiliate = Affiliate.new
  end

  def create
    @affiliate = @scope.affiliates.build(affiliate_attributes)
    if @affiliate.save
      flash[:notice] = 'Speichern Erfolgreich'
      redirect_to backend_scope_affiliate_path(@scope, @affiliate)
    else
      flash[:error] = 'Fehler beim Speiechern'
      render 'new'
    end
  end


  def show
    @affiliate = @scope.affiliates.where(id: params[:id]).first
    @unmapped_categories = MappingService.new(@affiliate).all_categories

    for mapping in @affiliate.mappings
      @unmapped_categories.delete(mapping.name)
    end

    for unmapped_category in @unmapped_categories
      @affiliate.mappings.build(name: unmapped_category)
    end

  end


  def update
    @affiliate = @scope.affiliates.where(id: params[:id]).first
    @affiliate.update(affiliate_attributes)
    @unmapped_categories = MappingService.new(@affiliate).all_categories

    for mapping in @affiliate.mappings
      @unmapped_categories.delete(mapping.name)
    end

    for unmapped_category in @unmapped_categories
      @affiliate.mappings.build(name: unmapped_category)
    end

    render 'show'
  end

protected

  def find_scope
    @scope = Scope.find(params[:scope_id])
  end

  def affiliate_attributes
    params.require(:affiliate).permit(:name,
                                      :file,
                                      :importer,
                                      :item_tag,
                                      :category_tag,
                                      :category_split_char,
                                      :mappings_attributes => [:id ,:name, :category_id])
  end


end
