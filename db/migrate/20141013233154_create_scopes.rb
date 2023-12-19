# frozen_string_literal: true

class CreateScopes < ActiveRecord::Migration[4.2]
  def change
    create_table :scopes do |t|
      t.string :country_code
      t.string :locale
      t.timestamps
    end
    add_index :scopes, :country_code, unique: true
  end
end
