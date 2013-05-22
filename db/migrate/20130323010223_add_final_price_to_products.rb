class AddFinalPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :final_price, :decimal, :default => 0.0
  end
end
