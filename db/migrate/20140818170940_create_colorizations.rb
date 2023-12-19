# frozen_string_literal: true

class CreateColorizations < ActiveRecord::Migration[4.2]
  def change
    create_table :colorizations do |t|
      t.string :name
    end
    add_index :colorizations, :name
  end
end
