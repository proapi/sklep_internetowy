class AddSubtitleToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :subtitle, :string, :default => nil
  end

  def self.down
    remove_column :articles, :subtitle
  end
end
