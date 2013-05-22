class AddReadyToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :ready, :boolean, :default => false
  end

  def self.down
    remove_column :articles, :ready
  end
end
