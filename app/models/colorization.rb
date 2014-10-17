class Colorization < ActiveRecord::Base
  has_many :products
  has_many :color_words
  has_and_belongs_to_many :words
end
