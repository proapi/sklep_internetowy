class AddHitsQuantityToProducts < ActiveRecord::Migration
  def change
    add_column :products, :hits_quantity, :integer, :default => 0
  end
end
