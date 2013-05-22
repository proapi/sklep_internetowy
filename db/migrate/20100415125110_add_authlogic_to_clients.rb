class AddAuthlogicToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :crypted_password, :string, :null => false
    add_column :clients, :password_salt, :string, :null => false
    add_column :clients, :persistence_token, :string, :null => false
    add_column :clients, :single_access_token, :string, :null => false
    add_column :clients, :perishable_token, :string, :null => false

    add_column :clients, :login_count, :integer, :null => false, :default => 0
    add_column :clients, :failed_login_count, :integer, :null => false, :default => 0
    add_column :clients, :last_request_at, :datetime
    add_column :clients, :current_login_at, :datetime
    add_column :clients, :last_login_at, :datetime
    add_column :clients, :current_login_ip, :string
    add_column :clients, :last_login_ip, :string
  end

  def self.down
    remove_column :clients, :crypted_passwords
    remove_column :clients, :password_salt
    remove_column :clients, :persistence_token
    remove_column :clients, :single_access_token
    remove_column :clients, :perishable_token

    remove_column :clients, :login_count
    remove_column :clients, :failed_login_count
    remove_column :clients, :last_request_at
    remove_column :clients, :current_login_at
    remove_column :clients, :last_login_at
    remove_column :clients, :current_login_ip
    remove_column :clients, :last_login_ip
  end
end
