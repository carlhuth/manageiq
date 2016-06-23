if defined?(RSpec) && defined?(RSpec::Core::RakeTask)
  namespace :test do
    namespace 'manageiq-providers-vmware-vcd' do
      desc "Setup environment for vmware-vcd specs"
      task :setup => [:initialize, :verify_no_db_access_loading_rails_environment, :setup_db]
    end

    desc "Run all vmware-vcd specs"
    RSpec::Core::RakeTask.new('manageiq-providers-vmware-vcd' => [:initialize, "evm:compile_sti_loader"]) do |t|
      EvmTestHelper.init_rspec_task(t)
      t.pattern = FileList['gems/manageiq-providers-vmware-vcd/spec/**/*_spec.rb']
    end
  end
end # ifdef
