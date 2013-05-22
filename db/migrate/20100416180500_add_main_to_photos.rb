class AddMainToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :main, :boolean
    add_column :photos, :description, :text
  end

  def self.down
    remove_column :photos, :main
    remove_column :photos, :description
  end
end
