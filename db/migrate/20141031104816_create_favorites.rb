# frozen_string_literal: true

class CreateFavorites < ActiveRecord::Migration[4.2]
  def change
    create_table :favorites do |t|
      t.references :product, index: true
      t.references :user, index: true
      t.string :cookie_store
      t.timestamps
    end
    add_index :favorites, :cookie_store
  end
end
