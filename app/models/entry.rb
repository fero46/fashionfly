class Entry < ActiveRecord::Base
  belongs_to :feed
  belongs_to :scope
  serialize :content
  mount_uploader :image, BlogUploader

  default_scope {order(:published => :desc)}

  acts_as_taggable


  after_create :check_image


  def check_image
    EntryImageCacheWorker.run(self.id)
  end

   def url_safe url
     url.downcase.gsub(/[^a-zA-Z0-9]+/, '-').gsub(/-{2,}/, '-').gsub(/^-|-$/, '') if url.exists
   end

   def to_param
     "#{id}-#{url_safe(title)}"
   end


   def cache_remote_image

    inner = self.content if self.content.present?
    inner = self.summary if inner.blank?

    html = Nokogiri::HTML.fragment(inner)
    images = html.css('img')
    if images.any? && self.image.blank?
      src = images.attr('src').value()
      self.remote_image_url = src
      ActiveRecord::Base.connection_pool.with_connection do
        save
      end
    else
      nil
    end
   end

   def products
    analyze_text = self.content if self.content.present?
    analyze_text = self.summary if analyze_text.blank?
    analyze_text = analyze_text.downcase if analyze_text.present?
    categories = scope.categories.map {|n| [n.id , n.name.downcase]}
    colors = Colorization.all.map{ |c| c.name }
    color_map = {}
    colors.each{ |c| color_map[I18n.t('products.show._'+c).downcase] = c}
    cat = nil
    col = nil

    if analyze_text.present?
      analyze_text = analyze_text.force_encoding("utf-8")
      for category in categories
        cat = category[0] if analyze_text[category[1]]
      end

      for key in color_map.keys
        col = color_map[key] if analyze_text[key]
      end
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
