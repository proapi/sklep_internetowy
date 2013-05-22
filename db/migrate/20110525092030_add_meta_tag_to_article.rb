class AddMetaTagToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :meta_title, :string
    add_column :articles, :meta_keywords, :string
    add_column :articles, :meta_description, :string
  end

  def self.down
    remove_column :articles, :meta_title
    remove_column :articles, :meta_keywords
    remove_column :articles, :meta_description
  end
end
