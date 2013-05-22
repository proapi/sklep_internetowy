class ChangeProduct < ActiveRecord::Migration
  def self.up
    remove_column :products, :warranty
    remove_column :products, :features

    add_column :products, :author, :string
    add_column :products, :book_format, :string
    add_column :products, :page_count, :integer
  end

  def self.down
    add_column :products, :warranty, :string
    add_column :products, :features, :string

    remove_column :products, :author
    remove_column :products, :book_format
    remove_column :products, :page_count
  end
end
