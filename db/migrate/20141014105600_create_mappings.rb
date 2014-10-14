class CreateMappings < ActiveRecord::Migration
  def change
    create_table :mappings do |t|
      t.references :category, index: true
      t.string :name

      t.timestamps
    end
    add_index :mappings, :name
  end
end
