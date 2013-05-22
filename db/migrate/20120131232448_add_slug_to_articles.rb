class AddSlugToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :slug, :string, unique: true
    add_index :articles, :slug
  end
end
