class CreateIcons < ActiveRecord::Migration
  def change
    create_table :icons do |t|
      t.string :name
      t.string :image
    end
    add_index :icons, :name
  end
end
