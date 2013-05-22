class AddPromotionToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :is_promotion, :boolean
    add_column :products, :promotion_price, :decimal, :precision => 8, :scale => 2
    add_column :products, :promotion_text, :string
  end

  def self.down
    remove_column :products, :is_promotion
    remove_column :products, :promotion_price
    remove_column :products, :promotion_text
  end
end
