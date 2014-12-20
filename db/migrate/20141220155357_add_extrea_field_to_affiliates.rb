class AddExtreaFieldToAffiliates < ActiveRecord::Migration
  def change
    add_column :affiliates, :replace_only_images, :boolean, default: false 
  end
end
