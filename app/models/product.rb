class Product < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :categories, :through => :categorizations
  has_many :favorites, as: :markable, dependent: :destroy
  has_many :subscriptions, class_name: 'FashionFlyEditor::Subscription', as: :subscriber
  has_many :collections, through: :subscriptions, class_name: 'FashionFlyEditor::Collection'
  belongs_to :brand
  belongs_to :colorization
  belongs_to :scope
  belongs_to :affiliate
  
  mount_uploader :image, ImageUploader
  mount_uploader :original, OriginalUploader

  validates :scope, presence: true, if: :published?
  validates :colorization, presence: true, if: :published?
  validates :brand, presence: true, if: :published?
  # validates :description, presence: true, if: :published?

  ratyrate_rateable "rate"


  def self.trends
    where(published: true).order('actual_trend ASC')
  end

  def self.recolor
    Product.find_in_batches(batch_size: 500) do |group|
      group.each { |product| product.match_color }
    end
  end

  def published?
    self.published
  end


  def similar_products
    category = self.categories.where(leaf: true).first
    products = category.products.where(published: true)
    products = products.where(colorization_id: self.colorization_id) if colorization.present?
    products.where('products.id != ?', self.id).group('products.id').offset(rand(products.count)).limit(4)
  end


  def used_in_collections
    collections.where(published: true).
                group('fashion_fly_editor_collections.id').
                order('created_at DESC').
                limit(4)
  end

  def maincolor my_image_path=nil
    return @avg_color_hex if @avg_color_hex
    image_path = nil
    image_path = my_image_path if my_image_path.present?
    image_path = image.url if image.present? && image_path.blank?
    if image_path.present?
      if  image_path.start_with?('http://') || image_path.start_with?('https://')
        img = Magick::Image::from_blob open(image_path).read
        img = img[0] if img.kind_of?(Array)
      else
        img =  Magick::Image.read(image_path).first
      end
      pix = img.scale(1, 1)
      @avg_color_hex = pix.to_color(pix.pixel_color(0,0))
      @avg_color_hex = @avg_color_hex[0...(7-@avg_color_hex.length)] if @avg_color_hex.length > 7
    else
      @avg_color_hex = "#000000"
    end
    return @avg_color_hex
  end

  def match_color image=nil
    colors = Colorization.colorhex

    nearest = colors[0]
    mindist = distance(colors[0], image)
    for color in colors
      dist = distance(color, image)
      if dist < mindist
        nearest = color
        mindist = dist
      end
    end

    self.colorization_id = Colorization.where(name:nearest).first.try(:id)
    save!
    nearest
  end

  def distance color, image=nil
    0 if maincolor(image).blank?
    yuv_1 = convert_to_yuv(maincolor)
    yuv_2 = convert_to_yuv(color)
    delta_y = yuv_1[0] - yuv_2[0]
    delta_u = yuv_1[1] - yuv_2[1]
    delta_v = yuv_1[2] - yuv_2[2]
    (delta_y * delta_y + delta_u * delta_u + delta_v * delta_v)
  end

  def convert_to_yuv color
    rgb = color.gsub('#', '')
    r = rgb[0,2].to_i(16)
    g = rgb[2,2].to_i(16)
    b = rgb[4,2].to_i(16)
    y = 0.299 * r + 0.587 * g + 0.114 * b
    u = 0.492 * (b - y)
    v = 0.877 * (r - y)
    [y,u,v]
  end

  def self.dedupe affiliate_id
    counter = 0
    grouped = where(affiliate_id: affiliate_id).
              group_by{|model|     [model.name,
                                    model.price,
                                    model.colorization_id]}
    grouped.values.each do |duplicates|
      check = duplicates.shift
      check.update(published: true) unless check.published
      counter+=1 if duplicates.length > 0
      duplicates.each{|double| double.update(published: false)} # duplicates can now be destroyed
    end
    counter
  end

  def url_safe url
    url.downcase.gsub(/[^a-zA-Z0-9]+/, '-').gsub(/-{2,}/, '-').gsub(/^-|-$/, '')
  end

  def to_param
    "#{id}-#{url_safe(name)}"
  end

end
