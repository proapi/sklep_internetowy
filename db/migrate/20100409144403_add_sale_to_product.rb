class AddSaleToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :is_sale, :boolean
    add_column :products, :sale_price, :decimal, :precision => 8, :scale => 2
    add_column :products, :sale_text, :string
  end

  def self.down
    remove_column :products, :is_sale
    remove_column :products, :sale_price
    remove_column :products, :sale_text
  end
end
