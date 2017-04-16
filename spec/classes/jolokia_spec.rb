require 'spec_helper'

describe 'jolokia' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'jolokia class without any parameters' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('jolokia') }
          it { is_expected.to contain_class('jolokia::install') }
          it { is_expected.to contain_file('/etc/jolokia').with_ensure('directory') }
        end

        context 'jolokia class with all parameters' do
          let(:params) do
            {
              jvm_agent_ensure: '1.3.3',
              jvm_agent_name:   'jolokia-agents',
              config_dir:       '/opt/etc/jolokia'
            }
          end

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('jolokia') }
          it { is_expected.to contain_file('/opt/etc/jolokia').with_ensure('directory') }
          it do
            is_expected.to contain_package('jolokia-agent').
              with_ensure('1.3.3').
              with_name('jolokia-agents')
          end
        end
      end
    end
  end
end
