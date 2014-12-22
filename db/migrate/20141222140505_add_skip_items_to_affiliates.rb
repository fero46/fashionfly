class AddSkipItemsToAffiliates < ActiveRecord::Migration
  def change
    add_column :affiliates, :skip_items, :integer, default: 0
  end
end
