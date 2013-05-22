class AddAddressToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :building_no, :integer
    add_column :orders, :place_no, :integer
    add_column :orders, :street, :string
    add_column :orders, :city, :string
    add_column :orders, :code, :string
  end

  def self.down
    rename_column :orders, :building_no
    rename_column :orders, :place_no
    rename_column :orders, :street
    remove_column :orders, :city
    remove_column :orders, :code
  end
end
