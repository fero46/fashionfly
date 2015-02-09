class Entry < ActiveRecord::Base
  belongs_to :feed
  belongs_to :scope
  serialize :content
  acts_as_taggable


   def url_safe url
     url.downcase.gsub(/[^a-zA-Z0-9]+/, '-').gsub(/-{2,}/, '-').gsub(/^-|-$/, '')
   end

   def to_param
     "#{id}-#{url_safe(title)}"
   end

   def products
    analyze_text = self.content.downcase
    categories = scope.categories.map {|n| [n.id , n.name.downcase]}
    colors = Colorization.all.map{ |c| c.name }
    color_map = {}
    colors.each{ |c| color_map[I18n.t('products.show._'+c).downcase] = c}
    cat = nil
    col = nil

    for category in categories
      cat = category[0] if analyze_text[category[1]]
    end

    for key in color_map.keys
      col = color_map[key] if analyze_text[key]
    end

    params = {}
    params[:category] = cat
    params[:color] = col
    params[:per] = 4
    products = ProductSearchService.new(scope, params).products(true)
    if products.blank?
      products = scope.products.order("Rand()").limit(4)
    end
    products
   end

end
