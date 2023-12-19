# frozen_string_literal: true

class Favorite < ActiveRecord::Base
  belongs_to :markable, polymorphic: true, counter_cache: true, touch: true
  belongs_to :user
  scope :products, -> { where(markable_type: Product) }
  scope :collections, -> { where(markable_type: FashionFlyEditor::Collection) }
end
