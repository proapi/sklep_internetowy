class ChangeOrder < ActiveRecord::Migration
  def self.up
    remove_column :orders, :done
    remove_column :orders, :sent
    add_column :orders, :status, :integer, :default => 0
  end

  def self.down
    remove_column :orders, :status
    add_column :orders, :done, :boolean, :default => false
    add_column :orders, :sent, :boolean, :default => false
  end
end
