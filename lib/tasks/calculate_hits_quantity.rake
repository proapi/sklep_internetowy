#encoding: utf-8

namespace :calculate_hits_quantity do
  desc "Calculates hits_quantity on products along all orders"
  task :execute => :environment do
    puts 'Starting calculations'

    puts 'Initializing products with hits_quantity=0'
    Product.all.each do |product|
      product.update_attribute :hits_quantity, 0
    end

    puts 'Generating and saving calculations'
    OrderItem.all.each do |order_item|
      product = Product.find_by_id(order_item.product_id)
      if product
        product.update_attribute(:hits_quantity, product.hits_quantity + order_item.quantity)
      end
    end

    puts 'Showing final results'
    Product.all.each do |product|
      puts "Product: #{product.id} Ilość: #{product.hits_quantity}"
    end
    puts 'Stopping calculations'
  end
end