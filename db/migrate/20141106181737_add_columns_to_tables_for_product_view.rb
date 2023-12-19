# frozen_string_literal: true

class AddColumnsToTablesForProductView < ActiveRecord::Migration[4.2]
  def up
    add_column :affiliates, :logo, :string
    add_column :affiliates, :free_shipping, :boolean, default: false
    add_column :affiliates, :pay_invoice, :boolean, default: false
    add_column :affiliates, :premium, :boolean, default: false
    add_column :products, :affiliate_id, :integer
    add_column :products, :premium, :boolean, default: false
    remove_index :products, name: :affi_name
    remove_columns :products, :affi_shop
    add_index :products, :premium
    add_index :products, :affiliate_id
    add_index :products, %i[affiliate_id affi_code scope_id], unique: true
  end

  def down
    remove_index :products, %i[affiliate_id affi_code scope_id]
    remove_index :products, :affiliate_id
    add_column :products, :affi_shop, :string
    add_index :products, %i[affi_shop affi_code], name: :affi_name
    remove_columns :products, :affiliate_id
    remove_columns :products, :premium
    remove_columns :affiliates, :premium
    remove_columns :affiliates, :pay_invoice
    remove_columns :affiliates, :free_shipping
    remove_columns :affiliates, :logo
  end
end
