class AddTotalAndPaymentToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total, :decimal, default: 0.0
    add_column :orders, :delivery_payment, :decimal, default: 0.0
  end
end
