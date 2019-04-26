class ChangeDataTypeForSummary < ActiveRecord::Migration[4.2]
  def change
    change_column :entries, :summary,  :binary,  :limit => 10.megabyte
  end
end
