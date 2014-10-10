class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
    end

    add_index :brands, :name
  end
end
