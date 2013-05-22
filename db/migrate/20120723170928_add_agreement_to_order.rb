class AddAgreementToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :agreement, :boolean, default: false, not_null: true
  end
end
