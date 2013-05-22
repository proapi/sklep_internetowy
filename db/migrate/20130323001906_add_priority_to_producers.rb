class AddPriorityToProducers < ActiveRecord::Migration
  def change
    add_column :producers, :priority, :integer, :default => 1000
  end
end
