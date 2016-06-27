class AddVappIdToVms < ActiveRecord::Migration[5.0]
  def change
    add_column :vms, :vapp_id, :bigint
    add_index :vms, :vapp_id
  end
end
