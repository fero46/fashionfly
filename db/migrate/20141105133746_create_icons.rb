# frozen_string_literal: true

class CreateIcons < ActiveRecord::Migration[4.2]
  def change
    create_table :icons do |t|
      t.string :name
      t.string :image
    end
    add_index :icons, :name
  end
end
