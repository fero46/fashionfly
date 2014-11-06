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


  def published?
    self.published
  end

  def copy_trend!
    self.last_trend = self.actual_trend
    save!
  end

  def add_previous_trend! new_value
    new_value = 0 if new_value.blank?
    if self.last_trend > 0 
      self.actual_trend = new_value + (self.last_trend * 0.5).to_i
      save!
    end
  end

  def similar_products
    category = self.categories.where(leaf: true).first
    category.products.where(colorization_id: self.colorization_id).where('products.id != ?', self.id).limit(4)
  end
end
