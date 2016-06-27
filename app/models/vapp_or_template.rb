class VappOrTemplate < ApplicationRecord
  self.table_name = 'vapps'

  VENDOR_TYPES = {
    # DB            Displayed
    "vmware"    => "VMware",
    "unknown"   => "Unknown"
  }

  validates_presence_of     :name, :location
  validates                 :vendor, :inclusion => {:in => VENDOR_TYPES.keys}

  belongs_to                :ext_management_system, :foreign_key => "ems_id"
end
