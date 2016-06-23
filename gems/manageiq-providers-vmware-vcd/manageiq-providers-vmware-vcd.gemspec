$:.push File.expand_path("../lib", __FILE__)

require "manageiq/providers/vmware_vcd/version"

Gem::Specification.new do |s|
  s.name        = "manageiq-providers-vmware-vcd"
  s.version     = ManageIQ::Providers::VmwareVcd::VERSION
  s.authors     = ["ManageIQ Developers"]
  s.homepage    = "https://github.com/ManageIQ/manageiq"
  s.summary     = "Vmware vCloud Director Provider for ManageIQ"
  s.description = "Vmware vCloud Director Provider for ManageIQ"
  s.licenses    = ["Apache-2.0"]

  s.files = Dir["{app,lib}/**/*"]

  s.add_dependency("fog-vcloud-director", ["~> 0.1.0"])
end
