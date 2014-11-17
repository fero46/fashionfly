class AddSecretToUsers < ActiveRecord::Migration
  def change
    add_column :users, :secret, :string
    add_index :users, :secret
  end
end
