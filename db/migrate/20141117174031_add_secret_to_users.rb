# frozen_string_literal: true

class AddSecretToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :secret, :string
    add_index :users, :secret
  end
end
