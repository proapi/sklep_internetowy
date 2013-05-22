class CreatePackMachines < ActiveRecord::Migration
  def change
    create_table :pack_machines do |t|
      t.string :name
      t.string :province
      t.string :postcode
      t.string :town
      t.string :street
      t.string :building_number
      t.string :latitude
      t.string :longitude
      t.string :status
      t.string :location_description
      t.string :operating_hours
      t.string :payment_point_description
      t.string :partner_id
      t.string :payment_type
      t.string :payment_available
      t.string :type

      t.timestamps
    end
  end
end
