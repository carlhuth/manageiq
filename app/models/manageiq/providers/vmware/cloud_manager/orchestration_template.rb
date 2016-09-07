class ManageIQ::Providers::Vmware::CloudManager::OrchestrationTemplate < OrchestrationTemplate
  def parameter_groups
    [OrchestrationTemplate::OrchestrationParameterGroup.new(
      :label      => "Parameters",
      :parameters => []
    )]
  end

  def self.eligible_manager_types
    [ManageIQ::Providers::Vmware::CloudManager]
  end
end
