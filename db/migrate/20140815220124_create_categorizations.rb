class CreateCategorizations < ActiveRecord::Migration[4.2]
  def change
    create_table :categorizations do |t|
      t.integer :product_id
      t.integer :category_id
      t.timestamps
    end
  end
end
