class CreateBrands < ActiveRecord::Migration[4.2]
  def change
    create_table :brands do |t|
      t.string :name
    end

    add_index :brands, :name
  end
end
