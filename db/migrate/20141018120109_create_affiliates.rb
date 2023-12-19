# frozen_string_literal: true

class CreateAffiliates < ActiveRecord::Migration[4.2]
  def change
    create_table :affiliates do |t|
      t.string :file
      t.string :name
      t.boolean :ready
      t.references :scope, index: true
      t.string :item_tag
      t.string :category_tag
      t.string :category_split_char
      t.string :ean_tag
      t.string :image_tag
      t.string :name_tag
      t.string :number_tag
      t.string :description_tag
      t.string :brand_tag
      t.string :price_tag
      t.string :shipping_cost_tag
      t.string :last_modified_tag
      t.string :delivery_time_tag
      t.string :currency_code_tag
      t.string :link_tag
      t.string :importer

      t.timestamps
    end
  end
end
