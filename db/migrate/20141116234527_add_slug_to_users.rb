class AddSlugToUsers < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string, after: :role 
    add_index :users, :slug
  end
end
