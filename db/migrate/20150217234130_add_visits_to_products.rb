class AddVisitsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :visits_count, :integer, default: 0 
  end
end
