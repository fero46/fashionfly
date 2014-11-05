class AddPublishedToScope < ActiveRecord::Migration
  def change
    add_column :scopes, :published, :boolean, default: false
    add_index :scopes, :published
  end
end
