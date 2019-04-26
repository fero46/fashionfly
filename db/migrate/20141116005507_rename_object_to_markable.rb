class RenameObjectToMarkable < ActiveRecord::Migration[4.2]
  def change
    rename_column :favorites, :object_id, :markable_id
    rename_column :favorites, :object_type, :markable_type
  end
end
