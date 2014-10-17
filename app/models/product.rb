class Product < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :categories
  belongs_to :brand
  belongs_to :colorization
  belongs_to :scope
  
  mount_uploader :image, ImageUploader
  mount_uploader :original, OriginalUploader

  validates :scope, presence: true
  validates :colorization, presence: true
  validates :brand, presence: true
  validates :description, presence: true

end
