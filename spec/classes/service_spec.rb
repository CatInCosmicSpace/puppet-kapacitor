# frozen_string_literal: true

require 'spec_helper'

describe 'kapacitor::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) do
        <<-PUPPET
        file { ['/lib/systemd/system/kapacitor.service', '/etc/systemd/system/kapacitor.service']: }
        PUPPET
      end
      let :params do
        {
          'service_name' => 'kapacitor',
          'service_ensure' => 'running',
          'service_enable' => true,
          'service_has_status' => true,
          'service_has_restart' => true,
          'service_provider' => 'systemd',
          'manage_service' => true,
          'service_definition' => '/lib/systemd/system/kapacitor.service',
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('kapacitor::service')
        if facts[:os]['family'] == 'Debian'
          is_expected.to contain_service('kapacitor').that_subscribes_to(['File[/lib/systemd/system/kapacitor.service]'])
        end
      end

      context 'on RedHat' do
        let :params do
          {
            'service_name' => 'kapacitor',
            'service_ensure' => 'running',
            'service_enable' => true,
            'service_has_status' => true,
            'service_has_restart' => true,
            'service_provider' => 'systemd',
            'manage_service' => true,
            'service_definition' => '/etc/systemd/system/kapacitor.service',
          }
        end

        it do
          if facts[:os]['family'] == 'RedHat'
            is_expected.to contain_service('kapacitor').that_subscribes_to(['File[/etc/systemd/system/kapacitor.service]'])
          end
        end
      end
    end
  end
end
