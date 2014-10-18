class AddAfilliateToMappings < ActiveRecord::Migration
  def change
    add_reference :mappings, :affiliate, index: true
  end
end
