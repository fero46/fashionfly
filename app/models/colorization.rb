# frozen_string_literal: true

class Colorization < ActiveRecord::Base
  has_many :products
  has_many :color_words
  has_and_belongs_to_many :words

  def self.colorhex
    return @hex if @hex.present?

    @hex = Colorization.order(:id).map(&:name)
  end
end
