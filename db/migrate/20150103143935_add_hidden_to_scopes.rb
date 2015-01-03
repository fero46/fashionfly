class AddHiddenToScopes < ActiveRecord::Migration
  def change
    add_column :scopes, :hidden, :text
  end
end
