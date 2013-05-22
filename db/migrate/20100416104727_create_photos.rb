class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :parent_id
      t.string :content_type
      t.string :filename
      t.string :thumbnail
      t.integer :size
      t.integer :width
      t.integer :height
      t.integer :product_id
    end
  end

  def self.down
    drop_table :photos
  end
end
