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

        case facts[:os]['name']
        when 'Debian' 'Ubuntu'
          is_expected.to have_class_count(10)
          is_expected.to have_resource_count(28)
        when 'CentOS'
          is_expected.to have_class_count(7)
          is_expected.to have_resource_count(14)
        end
      end
    end
  end
end
