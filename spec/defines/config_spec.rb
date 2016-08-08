require 'spec_helper'

describe 'jolokia::config', type: :define do
  let :pre_condition do
    'include ::jolokia'
  end
  let(:title) { 'puppetserver' }
  let(:params) do
    {
      ensure:        'file',
      properties: { 'config' => '/etc/jolokia/security.xml',
                    'host'   => '*',
                    'port'   => '7887'
                  }
    }
  end

  props = <<-PROPS.gsub(/^ {4}/, '')
    # This file is controlled by puppet
    # LOCAL CHANGES WILL BE OVERWRITTEN
    #
    config=/etc/jolokia/security.xml
    host=*
    port=7887
  PROPS

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'jolokia::config with all parameters' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_file('/etc/jolokia/puppetserver.properties').with_ensure('file') }
          it { is_expected.to contain_file('/etc/jolokia/puppetserver.properties').with_content(props) }
        end
      end
    end
  end
end

