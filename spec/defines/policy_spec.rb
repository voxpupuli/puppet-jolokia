require 'spec_helper'

describe 'jolokia::policy', type: :define do
  let :pre_condition do
    'include ::jolokia'
  end
  let(:title) { 'security' }
  let(:params) do
    {
      ensure:        'file',
      allowed_hosts: [ '1.1.1.1', '::1' ]
    }
  end

  policy = <<-POLICY.gsub(/^ {4}/, '')
    <?xml version="1.0" encoding="utf-8"?>
    <!-- This file is controlled by puppet -->
    <!-- LOCAL CHANGES WILL BE OVERWRITTEN -->
    <restrict>
      <remote>
        <host>1.1.1.1</host>
        <host>::1</host>
      </remote>
    </restrict>
  POLICY

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'jolokia::policy with all parameters' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_file('/etc/jolokia/security.xml').with_ensure('file') }
          it { is_expected.to contain_file('/etc/jolokia/security.xml').with_content(policy) }
        end
      end
    end
  end
end
