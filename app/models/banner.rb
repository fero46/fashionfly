# frozen_string_literal: true

class Banner < ActiveRecord::Base
  belongs_to :scope
  validates :name, presence: true
  validates :link, presence: true
  validates :banner, presence: true
  validates :preview_ids, presence: true
  validates :previews_model, presence: true
  validates :scope_id, presence: true
  mount_uploader :banner, SliderUploader
  def self.MODELS
    %i[Product Collection]
  end

  def items
    model = nil
    case previews_model
    when 'Product'
      model = scope.products
      model = model.where('id in (?)', preview_ids.split(','))
    when 'Collection'
      model = scope.collections
      model = model.where('collection_id in (?)', preview_ids.split(','))
    end
    if model.blank?
      Banner.none
    else
      model
    end
  end
end
