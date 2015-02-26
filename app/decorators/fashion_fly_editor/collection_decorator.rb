FashionFlyEditor::Collection.class_eval do
  include SimpleHashtag::Hashtaggable
  has_many :favorites, as: :markable, dependent: :destroy
  has_many :visits, as: :visitable, dependent: :destroy, counter_cache: true
  acts_as_commentable
  ratyrate_rateable "rate"
  hashtaggable_attribute :description


  # Overwrite SimpleHashtag-update_hashtags
  def update_hashtags
    if scope.present?
      self.hashtags = parsed_hashtags
    end
  end

  # Overwrite SimpleHashtag-parsed_hashtags
  def parsed_hashtags
    if scope.present?
      parsed_hashtags = []
      array_of_hashtags_as_string = scan_for_hashtags(hashtaggable_content)
      array_of_hashtags_as_string.each do |s|
        parsed_hashtags << SimpleHashtag::Hashtag.where(name: s[1], scope_id: scope.id).first_or_create
      end
      parsed_hashtags
    end
  end

  def self.trends
    where(published: true).order('actual_trend DESC')
  end

  def locale
    scope.locale
  end

  def products
    Product.where('id in (?)', subscriptions.where('subscriber_type = ?', ::Product).select(:subscriber_id))
  end

  def scope
    mysubscriptions = subscriptions.where('subscriber_type = ?', ::Scope).select(:subscriber_id)
    if mysubscriptions.present?
      Scope.where('id in (?)', mysubscriptions).first
    else
      ::Scope.none
    end
  end

  def rebuild_image
    build_image
  end

   def url_safe url
     url.downcase.gsub(/[^a-zA-Z0-9]+/, '-').gsub(/-{2,}/, '-').gsub(/^-|-$/, '')
   end

   def to_param
     "#{id}-#{url_safe(title)}"
   end

private

  def link_template name, link
    "<a href=#{link} title='#{name}' alt='#{name}'>#{name}</a>"
  end

end