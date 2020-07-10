# frozen_string_literal: true

require 'spec_helper'

describe 'kapacitor' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('kapacitor')
        is_expected.to contain_class('kapacitor::repo').that_comes_before('Class[kapacitor::install]')
        is_expected.to contain_class('kapacitor::install').that_comes_before(['Class[kapacitor::config]', 'Class[kapacitor::service]'])
        is_expected.to contain_class('kapacitor::config').that_notifies('Class[kapacitor::service]')

        case facts[:os]['name']
          when 'Debian'
            is_expected.to have_class_count(9)
            is_expected.to have_resource_count(30)
          when 'Ubuntu'
            is_expected.to have_class_count(9)
            is_expected.to have_resource_count(29)
          when 'CentOS'
            is_expected.to have_class_count(6)
            is_expected.to have_resource_count(15)
         end
      end
    end
  end
end
