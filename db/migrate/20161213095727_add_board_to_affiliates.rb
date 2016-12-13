class AddBoardToAffiliates < ActiveRecord::Migration
  def change
    add_column :affiliates, :board_number, :string
  end
end
