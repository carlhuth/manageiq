class ManageIQ::Providers::VmwareVcd::CloudManager::RefreshParser < ManageIQ::Providers::CloudManager::RefreshParser
  def self.ems_inv_to_hashes(ems, inv, options = nil)
    new(ems, inv, options).ems_inv_to_hashes
  end

  def initialize(ems, inv, options = Config::Options.new)
    @ems                 = ems
    @inv                 = inv
    @data                = {}
    @data_index          = {}
    @options             = options
  end

  def process_collection(collection, key)
    @data[key] ||= []

    collection.each do |item|
      uid, new_result = yield(item)
      next if uid.nil?

      @data[key] << new_result
      @data_index.store_path(key, uid, new_result)
    end
  end

  def ems_inv_to_hashes
    log_header = "MIQ(#{self.class.name}.#{__method__}) Collecting data for EMS name: [#{@ems.name}] id: [#{@ems.id}]"

    $log.info("#{log_header}...")

    get_vapps
    get_vms

    $log.info("#{log_header}...Complete")

    @data
  end

  private

  def get_vapps
    process_collection(@inv[:vapps], :vapps) { |vapp| parse_vapp(vapp) }
  end

  def get_vms
    process_collection(@inv[:vms], :vms) { |vm| parse_vm(vm) }
  end

  def parse_vapp(vapp)
    status = vapp.human_status

    uid           = vapp.id
    name          = vapp.name
    deployed      = vapp.deployed

    new_result = {
      :type                => ManageIQ::Providers::VmwareVcd::CloudManager::Vapp.name,
      :uid_ems             => uid,
      :ems_ref             => uid,
      :name                => name,
      :vendor              => "vmware",
      :deployed            => deployed,
      :raw_power_state     => status,
      :location            => "unknown",

      # :cloud_network       => nil,
      # :cloud_subnet        => nil,
      # :orchestration_stack => nil,
    }

    return uid, new_result
  end

  def parse_vm(vm)
    status = vm.status

    uid           = vm.id
    name          = vm.name
    guest_os      = vm.operating_system
    bitness       = !(vm.operating_system =~ /64-bit/).nil? ? 64 : 32
    cpus          = vm.cpu
    memory_mb     = vm.memory
    disk_capacity = vm.hard_disks.inject(0) { |sum, x| sum + x.values[0] } * 1.megabyte

    vm_disks = @inv[:vms_disks][vm.id]

    disks = vm_disks.select { |d| d.description == "Hard disk" }.map do |disk|
      parent = vm_disks.find { |d| d.id == disk.parent }

      {
        :device_name     => disk.name,
        :device_type     => "disk",
        :controller_type => parent.description,
        :size            => disk.capacity * 1.megabyte
      }
    end

    networks = vm.network_adapters.map do |net|
      {
        :description => "private",
        :ipaddress   => net[:ip_address],
      }
    end

    vapp_uid = vm.vapp_id
    vapp = @data_index.fetch_path(:vapps, vapp_uid)

    new_result = {
      :type                => ManageIQ::Providers::VmwareVcd::CloudManager::Vm.name,
      :uid_ems             => uid,
      :ems_ref             => uid,
      :name                => name,
      :vendor              => "vmware",
      :raw_power_state     => status,
      :boot_time           => nil,

      :hardware            => {
        :guest_os             => guest_os,
        :guest_os_full_name   => guest_os,
        :bitness              => bitness,
        :virtualization_type  => nil,
        :root_device_type     => nil,
        :cpu_sockets          => cpus,
        :cpu_cores_per_socket => 1,
        :cpu_total_cores      => cpus,
        :memory_mb            => memory_mb,
        :disk_capacity        => disk_capacity,
        :disks                => disks,
        :networks             => networks,
      },

      :operating_system    => {
        :product_name => guest_os,
      },

      :cloud_network       => nil,
      :cloud_subnet        => nil,
      :orchestration_stack => nil,

      :vapp                => vapp,
    }

    return uid, new_result
  end
end
