class RemoveFullNameAndDescShortFromProduct < ActiveRecord::Migration
  def self.up
    remove_column :products, :full_name
    remove_column :products, :desc_short
    rename_column :products, :desc_long, :description
  end

  def self.down
    add_column :products, :full_name, :string
    add_column :products, :desc_short, :text
    rename_column :products, :desc_long, :description
  end
end
