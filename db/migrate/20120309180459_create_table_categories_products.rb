class CreateTableCategoriesProducts < ActiveRecord::Migration
  def up
    create_table :categories_products, :id => false do |t|
      t.integer :category_id
      t.integer :product_id
    end

    Product.all.each do |product|
      if product && product.category_id
        sql = "INSERT INTO categories_products(category_id, product_id) VALUES (#{product.category_id}, #{product.id});"
        execute sql
      end
    end
  end

  def down
    drop_table :categories_products
  end
end
