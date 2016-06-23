class ManageIQ::Providers::VmwareVcd::CloudManager::RefreshWorker < ManageIQ::Providers::BaseManager::RefreshWorker
  require_nested :Runner
end
