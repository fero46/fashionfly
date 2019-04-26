class CreateCategories < ActiveRecord::Migration[4.2]
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
