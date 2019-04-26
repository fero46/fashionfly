class CreateRebuilders < ActiveRecord::Migration[4.2]
  def change
    create_table :rebuilders do |t|
      t.integer :collection_id, null: false
    end
    add_index :rebuilders, :collection_id, unique: true
  end
end
