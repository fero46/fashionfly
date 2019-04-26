class AddHiddenToScopes < ActiveRecord::Migration[4.2]
  def change
    add_column :scopes, :hidden, :text
  end
end
