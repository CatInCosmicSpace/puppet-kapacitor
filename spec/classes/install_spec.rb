# frozen_string_literal: true

require 'spec_helper'

describe 'kapacitor::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let :params do
        {
          'group' => 'kapacitor',
          'group_system' => true,
          'user' => 'kapacitor',
          'user_home' => '/var/lib/',
          'user_manage_home' => true,
          'user_system' => true,
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('kapacitor::install')
        is_expected.to contain_group('kapacitor')
        is_expected.to contain_user('kapacitor')
      end
    end
  end
end
