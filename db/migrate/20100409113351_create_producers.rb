class CreateProducers < ActiveRecord::Migration
  def self.up
    create_table :producers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :email
      t.string :telephone
      t.string :www
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :producers
  end
end
