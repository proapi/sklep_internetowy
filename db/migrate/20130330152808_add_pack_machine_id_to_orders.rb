class AddPackMachineIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :pack_machine_id, :integer
  end
end
