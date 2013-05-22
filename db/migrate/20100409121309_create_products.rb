class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :full_name
      t.text :desc_short
      t.text :desc_long
      t.string :warranty
      t.integer :producer_id
      t.integer :category_id
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :discount

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
