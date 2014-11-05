class ProductSearchService

  def initialize scope, params
    @params = params
    @scope = scope
  end

  def params
    @params
  end


  def products
    @products = Product.where(scope_id: @scope.id)
    if params[:category]
      @products = @products.joins(:categorizations).where("categorizations.category_id" => params[:category])
    end
    if params[:brand]
      @products = @products.where("products.brand_id" => params[:brand])      
    end
    if params[:color]
      color = Colorization.where(name: "##{params[:color]}").first
      @products = @products.where("products.colorization_id" => color.id) if color.present?
    end    
    if params[:price].present?
      range = params[:price].split("-").map(&:to_i) 
      if range.length == 2
        @products = @products.where('price BETWEEN ? AND ?',range[0],range[1])
      else
        greater = params[:price].gsub('>','')
        @products = @products.where('price > ?', greater)
      end
    end
    @products.page(params[:page]).per(params[:per].present? ? params[:per] : 10)
  end






end