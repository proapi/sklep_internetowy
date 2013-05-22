class AddUserAndClientToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :user_id, :integer
    add_column :messages, :client_id, :integer

    add_index :messages, :user_id
    add_index :messages, :client_id
  end
end
