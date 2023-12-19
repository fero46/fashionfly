# frozen_string_literal: true

class Configuration < ActiveRecord::Base
  validates :key, presence: true, uniqueness: true
  validates :value, presence: true
end
