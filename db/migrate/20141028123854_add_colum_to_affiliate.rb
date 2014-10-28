class AddColumToAffiliate < ActiveRecord::Migration
  def change
    add_column :affiliates, :importing, :boolean, default: false 
    add_column :affiliates, :percent, :integer, default: 0

    add_index :affiliates, :importing
  end
end
