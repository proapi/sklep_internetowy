class AddMetaTagsToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :meta_title, :string
    add_column :entries, :meta_keywords, :string
    add_column :entries, :meta_description, :string
  end

  def self.down
    remove_column :entries, :meta_title
    remove_column :entries, :meta_keywords
    remove_column :entries, :meta_description
  end
end
