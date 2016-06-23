FactoryGirl.define do
  factory :vm_vmware_vcd, :class => "ManageIQ::Providers::VmwareVcd::CloudManager::Vm", :parent => :vm_cloud do
    vendor          "vmware"
    raw_power_state "up"
  end
end
