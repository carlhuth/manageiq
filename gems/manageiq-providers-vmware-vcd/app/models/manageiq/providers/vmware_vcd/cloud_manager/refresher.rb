class ManageIQ::Providers::VmwareVcd::CloudManager::Refresher < ManageIQ::Providers::BaseManager::Refresher
  include ::EmsRefresh::Refreshers::EmsRefresherMixin

  def collect_inventory_for_targets(ems, targets)
    vcd = ems.vcd_service

    inv = {
      :orgs  => [],
      :vdcs  => [],
      :vapps => [],
      :vms   => [],
    }

    vcd.organizations.all.each do |org|
      inv[:orgs].push(org)
    end

    inv[:orgs].each do |org|
      org.vdcs.all.each do |vdc|
        inv[:vdcs].push(vdc)
      end
    end

    inv[:vdcs].each do |vdc|
      vdc.vapps.all.each do |vapp|
        inv[:vapps].push(vapp)
      end
    end

    inv[:vapps].each do |vapp|
      vapp.vms.all.each do |vm|
        inv[:vms].push(vm)
      end
    end

    targets_with_data = targets.collect do |target|
      _log.info "Filtering inventory for #{target.class} [#{target.name}] id: [#{target.id}]..."

      case target
      when Vm
        # we cannot get a vm directly because it has to be loaded through vApp otherwise vapp_id is missing
        inv[:vms].select! do |vm|
          vm.id == target.id
        end
      end

      _log.info "Filtering inventory...Complete"
      [target, inv]
    end

    ems.api_version = vcd.api_version
    ems.save

    targets_with_data
  end

  def parse_targeted_inventory(ems, _target, inventory)
    log_header = format_ems_for_logging(ems)
    _log.debug "#{log_header} Parsing inventory..."
    hashes, = Benchmark.realtime_block(:parse_inventory) do
      ::ManageIQ::Providers::VmwareVcd::CloudManager::RefreshParser.ems_inv_to_hashes(ems, inventory)
    end
    _log.debug "#{log_header} Parsing inventory...Complete"

    hashes
  end

  def post_process_refresh_classes
    [::Vm]
  end
end
