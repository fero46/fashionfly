class Product < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :categories
  belongs_to :brand
  belongs_to :colorization
  mount_uploader :image, ImageUploader
  mount_uploader :original, OriginalUploader

end
