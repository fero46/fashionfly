class Product < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :categories, :through => :categorizations
  belongs_to :brand
  belongs_to :colorization
  belongs_to :scope
  
  mount_uploader :image, ImageUploader
  mount_uploader :original, OriginalUploader

  validates :scope, presence: true, if: :published?
  validates :colorization, presence: true, if: :published?
  validates :brand, presence: true, if: :published?
  validates :description, presence: true, if: :published?


  def published?
    self.published
  end

end
