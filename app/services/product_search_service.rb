class ProductSearchService

  def initialize scope, params
    @params = params
    @scope = scope
  end

  def params
    @params
  end

  def index_title category
    color = ''
    if params[:color].present?
      color = I18n.t('products.show._'+params[:color])
    end
    name = "#{color} #{category.name} #{params[:page]}"
    name = name.split.map{|i| i.capitalize}.join(' ')
    name.strip!
    name
  end


  def products random_order=false
    @products = Product.where(scope_id: @scope.id, published: true)
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
    if params[:name].present?
        query = params[:name]
        @products = @products.where('name like ?',"%#{query}%")      
    end
    if random_order
      type = 9000
    else
      type = params[:sort_by].present? ? params[:sort_by] : 0
    end
    @products = order_product(@products, type.to_i)
    @products.page(params[:page]).per(params[:per].present? ? params[:per] : 9)
  end


  def order_product products, type
    if type == 1
      products = products.order(id: :asc)
    elsif type == 2
      products = products.order(actual_trend: :desc)
    elsif type == 3
      products = products.order(favorites_count: :desc)
    elsif type == 9000 #SPECIAL RANDOM
      products = products.order(random_order: :asc)
    else
      products = products.order(id: :desc)
    end
    products
  end




end