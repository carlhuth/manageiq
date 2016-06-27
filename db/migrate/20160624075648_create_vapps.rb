class CreateVapps < ActiveRecord::Migration[5.0]
  def change
    create_table :vapps do |t|
      t.string   :vendor
      t.string   :format
      t.string   :version
      t.string   :name
      t.text     :description
      t.string   :location
      t.bigint   :host_id
      t.datetime :last_sync_on
      t.datetime :created_on
      t.datetime :updated_on
      t.bigint   :storage_id
      t.string   :guid,                  :limit => 36
      t.bigint   :ems_id
      t.string   :uid_ems
      t.date     :retires_on
      t.boolean  :retired
      t.datetime :boot_time
      t.boolean  :deployed
      t.string   :power_state
      t.datetime :state_changed_on
      t.string   :previous_state
      t.string   :raw_power_state
      t.string   :connection_state
      t.boolean  :publicly_available
      t.datetime :last_perf_capture_on
      t.datetime :ems_created_on
      t.boolean  :template,                :default => false
      t.bigint   :evm_owner_id
      t.string   :ems_ref_obj
      t.bigint   :miq_group_id
      t.string   :type
      t.string   :ems_ref
      t.bigint   :ems_cluster_id
      t.bigint   :retirement_warn
      t.datetime :retirement_last_warn
      t.bigint   :availability_zone_id
      t.boolean  :cloud
      t.string   :retirement_state
      t.bigint   :cloud_network_id
      t.bigint   :cloud_subnet_id
      t.bigint   :resource_group_id
    end

    add_index :vapps, :availability_zone_id, :name => :index_vapps_on_availability_zone_id
    add_index :vapps, :ems_id, :name => :index_vapps_on_ems_id
    add_index :vapps, :evm_owner_id, :name => :index_vapps_on_evm_owner_id
    add_index :vapps, :guid, :name => :index_vapps_on_guid, :unique => true
    add_index :vapps, :host_id, :name => :index_vapps_on_host_id
    add_index :vapps, :location, :name => :index_vapps_on_location
    add_index :vapps, :miq_group_id, :name => :index_vapps_on_miq_group_id
    add_index :vapps, :name, :name => :index_vapps_on_name
    add_index :vapps, :storage_id, :name => :index_vapps_on_storage_id
    add_index :vapps, :uid_ems, :name => :index_vapps_on_vmm_uuid
  end
end
