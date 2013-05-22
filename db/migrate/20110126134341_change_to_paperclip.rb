class ChangeToPaperclip < ActiveRecord::Migration
  def self.up
    remove_column :photos, :parent_id
    remove_column :photos, :content_type
    remove_column :photos, :filename
    remove_column :photos, :thumbnail
    remove_column :photos, :size
    remove_column :photos, :width
    remove_column :photos, :height
    remove_column :photos, :main

    add_column :photos, :image_file_name, :string
    add_column :photos, :image_content_type, :string
    add_column :photos, :image_file_size, :integer
    add_column :photos, :image_updated_at, :datetime
  end

  def self.down
    remove_column :photos, :image_file_name
    remove_column :photos, :image_content_type
    remove_column :photos, :image_file_size
    remove_column :photos, :image_updated_at

    add_column :photos, :parent_id, :integer
    add_column :photos, :content_type, :string
    add_column :photos, :filename, :string
    add_column :photos, :thumbnail, :string
    add_column :photos, :size, :integer
    add_column :photos, :width, :integer
    add_column :photos, :height, :integer
    add_column :photos, :main, :boolean
  end
end
