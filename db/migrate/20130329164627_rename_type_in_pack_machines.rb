class RenameTypeInPackMachines < ActiveRecord::Migration
  def up
    rename_column :pack_machines, :type, :machine_type
  end

  def down
    rename_column :pack_machines, :machine_type, :type
  end
end
