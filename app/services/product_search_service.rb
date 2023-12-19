# frozen_string_literal: true

class ProductSearchService
  def initialize(scope, params)
    @params = params
    @scope = scope
  end

  attr_reader :params

  def index_title(category)
    color = ''
    color = I18n.t("products.show._#{params[:color]}") if params[:color].present?
    name = "#{color} #{category.name} #{params[:page]}"
    name = name.split.map(&:capitalize).join(' ')
    name.strip!
    name
  end

  def products(random_order = false)
    @products = Product.where(scope_id: @scope.id, removed: false)
    if params[:category]
      @products = @products.joins(:categorizations).where('categorizations.category_id' => params[:category])
    end
    @products = @products.where('products.brand_id' => params[:brand]) if params[:brand]
    if params[:color]
      color = Colorization.where(name: "##{params[:color]}").first
      @products = @products.where('products.colorization_id' => color.id) if color.present?
    end
    if params[:price].present?
      range = params[:price].split('-').map(&:to_i)
      if range.length == 2
        @products = @products.where('price BETWEEN ? AND ?', range[0], range[1])
      else
        greater = params[:price].gsub('>', '')
        @products = @products.where('price > ?', greater)
      end
    end
    if params[:name].present?
      query = params[:name]
      @products = @products.where('name like ?', "%#{query}%")
    end
    type = if random_order
             9000
           else
             params[:sort_by].present? ? params[:sort_by] : 0
           end
    @products = order_product(@products, type.to_i)
    @products.page(params[:page]).per(params[:per].present? ? params[:per] : 9)
  end

  def order_product(products, type)
    case type
    when 1
      products.order(id: :asc)
    when 2
      products.order(actual_trend: :desc)
    when 3
      products.order(favorites_count: :desc)
    when 9000 # SPECIAL RANDOM
      products.order(random_order: :asc)
    else
      products.order(id: :desc)
    end
  end
end
