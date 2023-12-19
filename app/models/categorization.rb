# frozen_string_literal: true

class Categorization < ActiveRecord::Base
  belongs_to :product
  belongs_to :category
end
