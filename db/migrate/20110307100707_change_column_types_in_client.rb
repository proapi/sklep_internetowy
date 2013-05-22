class ChangeColumnTypesInClient < ActiveRecord::Migration
  def self.up
    change_column :clients, :building_no, :string
    change_column :clients, :place_no, :string
  end

  def self.down
    change_column :clients, :building_no, :integer
    change_column :clients, :place_no, :integer
  end
end
