module ManageIQ::Providers
  class Vmware::CloudManager::OrchestrationServiceOptionConverter < ::ServiceOrchestration::OptionConverter
    def stack_create_options
      {
        :deploy  => stack_parameters['deploy'] == 'true',
        :powerOn => stack_parameters['powerOn'] == 'true',
        :vdc_id  => @dialog_options['dialog_availability_zone']
      }
    end
  end
end
