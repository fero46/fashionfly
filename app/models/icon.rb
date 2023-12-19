# frozen_string_literal: true

class Icon < ActiveRecord::Base
  has_and_belongs_to_many :categories

  validates :image, presence: true
  validates :name, presence: true

  mount_uploader :image, ImageUploader
end
