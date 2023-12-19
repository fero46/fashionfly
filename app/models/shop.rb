# frozen_string_literal: true

class Shop < ActiveRecord::Base
  belongs_to :scope
  has_many :banners

  validates :name, presence: true
  validates :logo, presence: true
  validates :body, presence: true
  validates :link, presence: true

  mount_uploader :logo, ShoplogoUploader
end
