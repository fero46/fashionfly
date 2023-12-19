# frozen_string_literal: true

class Mapping < ActiveRecord::Base
  belongs_to :affiliate, touch: true
  belongs_to :category
end
