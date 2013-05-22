class ChangeClient < ActiveRecord::Migration
  def self.up
    add_column :clients, :building_no, :integer
    add_column :clients, :place_no, :integer
    rename_column :clients, :address, :street
  end

  def self.down
    remove_column :clients, :building_no
    remove_column :clients, :place_no
    rename_column :clients, :street, :address
  end
end
