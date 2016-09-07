module ManageIQ::Providers
  class Vmware::CloudManager::OrchestrationServiceOptionConverter < ::ServiceOrchestration::OptionConverter
    def stack_create_options
      {
        :vdc_id => @dialog_options['dialog_availability_zone']
      }
    end
  end
end
