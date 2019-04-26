class CreatePages < ActiveRecord::Migration[4.2]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.text :body
      t.integer :scope_id
      t.timestamps
    end
    add_index :pages, :name
    add_index :pages, :scope_id
    add_index :pages, [:name, :scope_id], unique: true
  end
end
