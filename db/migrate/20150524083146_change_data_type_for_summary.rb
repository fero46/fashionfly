class ChangeDataTypeForSummary < ActiveRecord::Migration
  def change
    change_column :entries, :summary,  :binary,  :limit => 10.megabyte
  end
end
