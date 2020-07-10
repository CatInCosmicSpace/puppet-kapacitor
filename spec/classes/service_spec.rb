# frozen_string_literal: true

require 'spec_helper'

describe 'kapacitor::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let :params do
        {
          'service_name' => 'kapacitor',
          'service_ensure' => 'running',
          'service_enable' => true,
          'service_has_status' => true,
          'service_has_restart' => true,
          'service_provider' => 'systemd',
          'manage_service' => true,
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('kapacitor::service')
        is_expected.to contain_service('kapacitor')
      end
    end
  end
end
