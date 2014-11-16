class AddColumnsToContests < ActiveRecord::Migration
  def change
    add_column :contests, :startdate, :date
    add_index :contests, :startdate
    add_column :contests, :enddate, :date
    add_index :contests, :enddate
  end
end
