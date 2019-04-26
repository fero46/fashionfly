class AddTrendsFeaturetoProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :actual_trend, :integer, default: 0
    add_column :products, :last_trend, :integer, default: 0
    add_index :products, :actual_trend
    add_index :favorites, :created_at
  end
end
