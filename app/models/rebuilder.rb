class Rebuilder < ActiveRecord::Base
  validates :collection_id, presence: true 

  def retouch
    collection = FashionFlyEditor::Collection.where(id: self.collection_id).first
    dirty = false
    if collection.present?
      for collection_item in collection.collection_items
        product = Product.where(id: collection_item.item_id).first if collection_item.item_id.present?
        if product.present?
          remote_image  = product.image.url
          remote_image = "http://localhost:3000/#{remote_image}" if Rails.env.development? || Rails.env.test?
          collection_item.remote_image_url = remote_image
          collection_item.save
          dirty = true
        end
      end
      collection.rebuild_image if dirty
    end
    self.destroy
  end

end
