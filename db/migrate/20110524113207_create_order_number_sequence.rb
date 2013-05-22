class CreateOrderNumberSequence < ActiveRecord::Migration
  def self.up
    execute 'CREATE SEQUENCE order_number_seq START 700;'
  end

  def self.down
    execute 'DROP SEQUENCE order_number_seq;'
  end
end
