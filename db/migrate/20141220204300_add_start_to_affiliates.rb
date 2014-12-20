class AddStartToAffiliates < ActiveRecord::Migration
  def change
    add_column :affiliates, :start_from_id, :integer, :default => 0
  end
end
