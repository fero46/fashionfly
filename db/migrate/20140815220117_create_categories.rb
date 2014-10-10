class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :category_id
      t.string :slug
      t.timestamps
    end

    add_index :categories, :slug
  end
end
