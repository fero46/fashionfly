class AddPublishedToScope < ActiveRecord::Migration[4.2]
  def change
    add_column :scopes, :published, :boolean, default: false
    add_index :scopes, :published
  end
end
