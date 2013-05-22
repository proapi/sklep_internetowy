class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :number
      t.integer :client_id
      t.boolean :done
      t.boolean :sent
      t.text :notice
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
