# frozen_string_literal: true

class CollectionSearchService
  def initialize(scope, params)
    @params = params
    @scope = scope
  end

  attr_reader :params

  def collections
    @collections = @scope.collections.where(published: true)
    if params[:outfit_category]
      category = FashionFlyEditor::Category.where(id: params[:outfit_category]).first
      ids = list_ids(category)
      @collections = @collections.where('category_id in (?)', ids)
    end
    # if params[:price].present?
    #   range = params[:price].split("-").map(&:to_i)
    #   if range.length == 2
    #     @collections = @collections.where('price BETWEEN ? AND ?',range[0],range[1])
    #   else
    #     greater = params[:price].gsub('>','')
    #     @collections = @collections.where('price > ?', greater)
    #   end
    # end
    type = params[:sort_by].present? ? params[:sort_by] : 0
    @collections = order_product(@collections, type.to_i)
    @collections.page(params[:page]).per(params[:per].present? ? params[:per] : 9)
  end

  def order_product(collections, type)
    puts type
    case type
    when 1
      collections.order(id: :asc)
    when 2
      collections.order(actual_trend: :desc)
    when 3
      collections.order(favorites_count: :desc)
    else
      collections.order(id: :desc)
    end
  end

  def list_ids(category)
    result = []
    result << category.id
    category.categories.each do |subcategory|
      result.concat list_ids(subcategory)
    end
    result.uniq
  end
end
