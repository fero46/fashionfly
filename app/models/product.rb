class Product < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :categories, :through => :categorizations
  has_many :favorites, dependent: :destroy
  belongs_to :brand
  belongs_to :colorization
  belongs_to :scope
  belongs_to :affiliate
  
  mount_uploader :image, ImageUploader
  mount_uploader :original, OriginalUploader

  validates :scope, presence: true, if: :published?
  validates :colorization, presence: true, if: :published?
  validates :brand, presence: true, if: :published?
  validates :description, presence: true, if: :published?

  ratyrate_rateable "rate"


  def self.trends
    order('actual_trend DESC')
  end

  def self.recolor
    Product.find_in_batches(batch_size: 500) do |group|
      group.each { |product| product.match_color }
    end
  end

  def published?
    self.published
  end

  def copy_trend!
    self.last_trend = self.actual_trend
    save!
  end

  def add_previous_trend! new_value
    new_value = 0 if new_value.blank?
    self.actual_trend = new_value + (self.last_trend * 0.5).to_i
    save!
  end

  def similar_products
    category = self.categories.where(leaf: true).first
    products = category.products
    products = products.where(colorization_id: self.colorization_id) if colorization.present?
    products.where('products.id != ?', self.id).offset(rand(products.count)).limit(4)
  end


  def maincolor
    return @avg_color_hex if @avg_color_hex
    if image.present? && File.exist?(image.path)
      img =  Magick::Image.read(image.path).first
      pix = img.scale(1, 1)
      @avg_color_hex = pix.to_color(pix.pixel_color(0,0))
      @avg_color_hex = @avg_color_hex[0...(7-@avg_color_hex.length)] if @avg_color_hex.length > 7
    else
      @avg_color_hex = "#000000"
    end
    return @avg_color_hex
  end

  def match_color
    colors = Colorization.colorhex

    nearest = colors[0]
    mindist = distance(colors[0])
    for color in colors
      dist = distance(color)
      if dist < mindist
        nearest = color
        mindist = dist
      end
    end

    self.colorization_id = Colorization.where(name:nearest).first.try(:id)
    save!
    nearest
  end

  def distance color
    0 if maincolor.blank?
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

end
