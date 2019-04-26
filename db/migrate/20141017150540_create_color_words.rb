class CreateColorWords < ActiveRecord::Migration[4.2]
  def change
    create_table :color_words do |t|
      t.integer :scope_id
      t.integer :colorization_id
      t.string :sentence_part
      t.string :descriptive
    end
    add_index :color_words, :scope_id
    add_index :color_words, :colorization_id
  end
end
