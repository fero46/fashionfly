# frozen_string_literal: true

class AddMissingIndizies < ActiveRecord::Migration[4.2]
  def change
    add_index :categories, :category_id
    add_index :categorizations, :category_id
    add_index :categorizations, :product_id
    add_index :products, %i[affi_shop affi_code], name: 'affi_name'
    add_index :products, :colorization_id
    add_index :products, :brand_id
    add_index :categorizations, %i[category_id product_id]
    add_index :scopes, :locale
  end
end
