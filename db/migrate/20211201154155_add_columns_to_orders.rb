class AddColumnsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :order_number, :integer
    add_column :orders, :price, :integer
  end
end
