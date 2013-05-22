class ChangeColumnTypesInOrder < ActiveRecord::Migration
  def up
    change_column :orders, :building_no, :string
    change_column :orders, :place_no, :string
  end

  def down
    change_column :orders, :building_no, :integer
    change_column :orders, :place_no, :integer
  end
end
