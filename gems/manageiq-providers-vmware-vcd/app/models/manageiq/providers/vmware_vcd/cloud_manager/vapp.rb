class ManageIQ::Providers::VmwareVcd::CloudManager::Vapp < ManageIQ::Providers::CloudManager::Vapp
  POWER_STATES = {
    "creating" => "powering_up",
    "off"      => "off",
    "on"       => "on",
    "unknown"  => "terminated",
  }.freeze

  def self.calculate_power_state(raw_power_state)
    # https://github.com/xlab-si/fog-vcloud-director/blob/master/lib/fog/vcloud_director/models/compute/vapp.rb#L36
    POWER_STATES[raw_power_state.to_s] || "terminated"
  end
end
