class AddNestedSetAndOrderToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :lft, :integer
    add_column :categories, :rgt, :integer
    add_column :categories, :list_order, :integer
  end

  def self.down
    remove_column :categories, :lft
    remove_column :categories, :rgt
    remove_column :categories, :list_order
  end

end
