class RemoveSaleFromProduct < ActiveRecord::Migration
  def self.up
    remove_column :products, :is_sale
    remove_column :products, :sale_price
    remove_column :products, :sale_text
  end

  def self.down
    add_column :products, :is_sale, :boolean
    add_column :products, :sale_price, :numeric
    add_column :products, :sale_text, :string
  end
end
