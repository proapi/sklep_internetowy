class AddPaymentToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :payment, :integer, :default => 0
  end

  def self.down
    remove_column :orders, :payment
  end
end
