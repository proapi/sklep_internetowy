class AddTitleToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :title, :string, :null => false
    add_column :photos, :created_at, :timestamp
    add_column :photos, :updated_at, :timestamp
  end

  def self.down
    remove_column :photos, :title
    remove_column :photos, :created_at
    remove_column :photos, :updated_at
  end
end
