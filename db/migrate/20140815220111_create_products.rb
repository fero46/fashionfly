class CreateProducts < ActiveRecord::Migration[4.2]
  def change
    create_table :products do |t|
      t.string :affi_shop
      t.string :affi_code
      t.string :name
      t.string :number
      t.text :description
      t.integer :brand_id
      t.integer :colorization_id
      t.string :ean
      t.decimal :price,  :precision => 10, :scale => 2
      t.string :shippingHandlingCost
      t.string :lastModified
      t.string :image
      t.string :original
      t.string :deliveryTime
      t.string :currencyCode
      t.text :deepLink
      t.timestamps
    end
  end
end
