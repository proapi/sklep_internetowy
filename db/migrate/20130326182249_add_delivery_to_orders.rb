class AddDeliveryToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_method, :string, :default => 'Poczta Polska'
    add_column :orders, :delivery_info, :string
  end
end
