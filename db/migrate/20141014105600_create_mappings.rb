# frozen_string_literal: true

class CreateMappings < ActiveRecord::Migration[4.2]
  def change
    create_table :mappings do |t|
      t.references :category, index: true
      t.string :name

      t.timestamps
    end
    add_index :mappings, :name
  end
end
