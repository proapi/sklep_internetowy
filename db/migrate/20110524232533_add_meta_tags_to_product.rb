class AddMetaTagsToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :meta_title, :string
    add_column :products, :meta_keywords, :string
    add_column :products, :meta_description, :string
  end

  def self.down
    remove_column :products, :meta_title
    remove_column :products, :meta_keywords
    remove_column :products, :meta_description
  end
end
