class AddBoardToAffiliates < ActiveRecord::Migration[4.2]
  def change
    add_column :affiliates, :board_number, :string
  end
end
