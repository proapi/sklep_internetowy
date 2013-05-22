class AddAgreementToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :agreement, :boolean, :default => true
  end

  def self.down
    remove_column :clients, :agreement
  end
end
