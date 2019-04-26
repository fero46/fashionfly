class AddProfileColumnsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :banner, :string
    add_column :users, :info, :text
    add_column :users, :fashion_fly_editor_collections_count, :integer, default: 0
    add_column :users, :favorites_count, :integer, default: 0
    add_column :users, :five_star_rates_count, :integer, default: 0
    add_column :users, :visitors, :integer, default: 0
    add_column :users, :max_single_collection_share, :integer, default: 0
    add_column :users, :visits_count, :integer, default: 0
    add_column :fashion_fly_editor_collections, :visits_count, :integer, default: 0
  end
end
