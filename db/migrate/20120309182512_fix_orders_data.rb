class FixOrdersData < ActiveRecord::Migration
  def change
    Order.all.each do |order|
      if order.client
        order.full_name = order.client.full_name
        order.street = order.client.street
        order.building_no = order.client.building_no
        order.code = order.client.code
        order.city = order.client.city
        order.email = order.client.email
        order.save!
      end
    end
  end
end
