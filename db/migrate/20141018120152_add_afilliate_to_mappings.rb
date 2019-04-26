class AddAfilliateToMappings < ActiveRecord::Migration[4.2]
  def change
    add_reference :mappings, :affiliate, index: true
  end
end
