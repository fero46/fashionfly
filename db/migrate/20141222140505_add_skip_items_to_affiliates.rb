class AddSkipItemsToAffiliates < ActiveRecord::Migration[4.2]
  def change
    add_column :affiliates, :skip_items, :integer, default: 0
  end
end
