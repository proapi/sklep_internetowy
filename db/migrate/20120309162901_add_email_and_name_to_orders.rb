class AddEmailAndNameToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :full_name, :string
    add_column :orders, :email, :string
  end
end
