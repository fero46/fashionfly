class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
    add_index :configurations, :key, unique: true
  end
end
