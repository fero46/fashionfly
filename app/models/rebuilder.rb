# frozen_string_literal: true

class Rebuilder < ActiveRecord::Base
  validates :collection_id, presence: true

  def retouch
    collection = FashionFlyEditor::Collection.where(id: collection_id).first
    dirty = false
    if collection.present?
      collection.collection_items.each do |collection_item|
        product = Product.where(id: collection_item.item_id).first if collection_item.item_id.present?
        next unless product.present?

        remote_image = product.image.url
        remote_image = "http://localhost:3000/#{remote_image}" if Rails.env.development? || Rails.env.test?
        collection_item.remote_image_url = remote_image
        collection_item.save
        dirty = true
      end
      collection.rebuild_image if dirty
    end
    destroy
  end
end
