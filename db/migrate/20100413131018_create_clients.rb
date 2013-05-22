class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.boolean :private
      t.string :email
      t.string :telephone
      t.string :name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :code
      t.string :company
      t.string :company_nip
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
