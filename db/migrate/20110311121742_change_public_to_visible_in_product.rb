class ChangePublicToVisibleInProduct < ActiveRecord::Migration
  def self.up
    rename_column :products, :public, :visible
  end

  def self.down
    rename_column :products, :visible, :public
  end
end
