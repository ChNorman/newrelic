require 'spec_helper'

describe 'newrelic_lwrp_test::agent_dotnet' do
  before do
    stub_resources
  end

  context 'Windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:log_level => LOG_LEVEL, :platform => 'windows', :version => '2012', :step_into => ['newrelic_agent_dotnet']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Installs New Relic .Net agent' do
      expect(chef_run).to install_newrelic_agent_dotnet('Install')
    end

    it 'Install New Relic .NET Agent (windows_package)' do
      expect(chef_run).to install_windows_package('Install New Relic .NET Agent')
    end

    it 'Create newrelic.config file' do
      expect(chef_run).to render_file('C:\ProgramData\New Relic\.NET Agent\newrelic.config').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end
  end
end
