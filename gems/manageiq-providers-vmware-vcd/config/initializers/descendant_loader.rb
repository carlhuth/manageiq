# make sure STI models are recognized
DescendantLoader.instance.descendants_paths << ManageIQ::Providers::VmwareVcd::Engine.config.root.join('app/models')
