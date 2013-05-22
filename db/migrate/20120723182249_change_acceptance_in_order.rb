class ChangeAcceptanceInOrder < ActiveRecord::Migration
  def up
    remove_column :orders, :agreement
    add_column :orders, :agreement, :boolean, :default => true
  end

  def down
    remove_column :orders, :agreement
    add_column :orders, :agreement, :boolean, :default => true
  end
end
