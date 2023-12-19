# frozen_string_literal: true

class AddDimensionsToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :width, :integer, default: 0
    add_column :products, :height, :integer, default: 0
  end
end
