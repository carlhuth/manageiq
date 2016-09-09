class ManageIQ::Providers::Vmware::CloudManager::OrchestrationTemplate < OrchestrationTemplate
  def parameter_groups
    [OrchestrationTemplate::OrchestrationParameterGroup.new(
      :label      => "vApp Parameters",
      :parameters => vapp_parameters,
    )]
  end

  def vapp_parameters
    [
      OrchestrationTemplate::OrchestrationParameter.new(
        :name          => "deploy",
        :label         => "Deploy vApp",
        :data_type     => "boolean",
        :default_value => false,
        :constraints   => [
          OrchestrationTemplate::OrchestrationParameterAllowed.new(:allowed_values => [ "true", "false"])
        ]
      ),
      OrchestrationTemplate::OrchestrationParameter.new(
        :name          => "powerOn",
        :label         => "Power On vApp",
        :data_type     => "boolean",
        :default_value => false,
        :constraints   => [
          OrchestrationTemplate::OrchestrationParameterAllowed.new(:allowed_values => [ "true", "false"])
        ]
      )
    ]
  end

  def self.eligible_manager_types
    [ManageIQ::Providers::Vmware::CloudManager]
  end
end
