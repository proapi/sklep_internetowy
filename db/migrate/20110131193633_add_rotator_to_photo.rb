class AddRotatorToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :rotator, :boolean, :default => false
    add_column :photos, :rotator_order, :integer
    add_column :photos, :rotator_link, :string, :default => nil
  end

  def self.down
    remove_column :photos, :rotator
    remove_column :photos, :rotator_order
    remove_column :photos, :rotator_link
  end
end
