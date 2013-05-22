class CreateProductsRelationsTable < ActiveRecord::Migration
  def self.up
     create_table :products_relations, :id => false do |t|
      t.integer :product_id, :null => false
      t.integer :relation_id, :null => false
     end
  end

  def self.down
    drop_table :products_relations
  end
end
