# frozen_string_literal: true

require 'spec_helper'

describe 'kapacitor::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with all defaults'  do
      let :params do
        {
          'configuration_path' => '/etc/kapacitor',
          'configuration_file' => 'kapacitor.conf',
          'configuration_template' => 'kapacitor/kapacitor.conf.erb',
          'service_defaults' => '/etc/default/kapacitor',
          'service_default_template' => 'kapacitor/service-defaults.erb',
          'service_definition' => '/lib/systemd/system/kapacitor.service',
          'service_definition_template' => 'kapacitor/systemd.service.erb',
          'data_dir' => '/var/lib/kapacitor',
          'logging_file' => '/var/log/kapacitor/kapacitor.log',
          'load_dir' => '/etc/kapacitor/load',
          'replay_dir' => '/var/lib/kapacitor/replay',
          'task_dir' => '/var/lib/kapacitor/tasks',
          'storage_boltdb' => '/var/lib/kapacitor/kapacitor.db',
          'hostname' => 'localhost',
          'data_dir_manage' => 'directory',
          'skip_config_overrides' => false,
          'default_retention_policy' => '',
          'config_override_enabled' => true,
          'logging_file_manage' => 'present',
          'logging_level' => 'INFO',
          'load_enabled' => true,
          'load_dir_manage' => 'directory',
          'replay_dir_manage' => 'directory',
          'task_dir_manage' => 'directory',
          'task_snapshot_interval' => '60s',
          'storage_boltdb_manage' => 'present',
          'user' => 'foo',
          'group' => 'bar',
          'configuration_http' => {},
          'configuration_http_obligatory' => {
            'bind-address' => ':9999',
            'log-enabled' => true,
            'write-tracing' => false,
            'pprof-enabled' => false,
            'https-enabled' => false,
          },
          'configuration_tls' => {},
          'configuration_deadman' => {},
          'configuration_influxdb' => {},
          'configuration_kubernetes' => {},
          'configuration_smtp' => {},
          'configuration_snmptrap' => {},
          'configuration_opsgenie' => {},
          'configuration_opsgenie2' => {},
          'configuration_victorops' => {},
          'configuration_pagerduty' => {},
          'configuration_pagerduty2' => {},
          'configuration_pushover' => {},
          'configuration_httppost' => {},
          'configuration_slack' => {},
          'configuration_telegram' => {},
          'configuration_hipchat' => {},
          'configuration_kafka' => {},
          'configuration_alerta' => {},
          'configuration_sensu' => {},
          'configuration_reporting' => {},
          'configuration_stats' => {'enabled' => true,
                                    'stats-interval' => '55s',
                                    'database' => '_kap',
                                    'retention-policy' => 'ret_pol'},
          'configuration_udf' => {},
          'configuration_talk' => {},
          'configuration_mqtt' => {},
          'configuration_swarm' => {},
          'configuration_collectd' => {},
          'configuration_opentsdb' => {},
          'configuration_scraper' => {},
          'configuration_azure' => {},
          'configuration_consul' => {},
          'configuration_dns' => {},
          'configuration_ec2' => {},
          'configuration_file_discovery' => {},
          'configuration_gce' => {},
          'configuration_marathon' => {},
          'configuration_nerve' => {},
          'configuration_serverset' => {},
          'configuration_static_discovery' => {},
          'configuration_triton' => {},
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_file('/etc/kapacitor/kapacitor.conf')
          .with_content(%r{[http]})
          .with_content(%r{bind-address = \":9999\"})
          .with_content(%r{log-enabled = true})
          .with_content(%r{write-tracing = false})
          .with_content(%r{pprof-enabled = false})
          .with_content(%r{https-enabled = false})
          .with_content(%r{[stats]})
          .with_content(%r{enabled = true})
          .with_content(%r{stats-interval = \"55s\"})
          .with_content(%r{database = \"_kap\"})
          .with_content(%r{retention-policy = \"ret_pol\"})
        is_expected.to contain_file('/etc/default/kapacitor')
        is_expected.to contain_file('/var/lib/kapacitor')
        is_expected.to contain_file('/var/log/kapacitor/kapacitor.log')
          .with(owner:'foo', group: 'bar')
        is_expected.to contain_file('/etc/kapacitor/load')
        is_expected.to contain_file('/var/lib/kapacitor/replay')
          .with(owner:'foo', group: 'bar')
        is_expected.to contain_file('/var/lib/kapacitor/tasks')
          .with(owner:'foo', group: 'bar')
        is_expected.to contain_file('/var/lib/kapacitor/kapacitor.db')
          .with(owner:'foo', group: 'bar')

        if facts[:os]['family'] == 'Debian'
          is_expected.to contain_file('/lib/systemd/system/kapacitor.service')
        end
      end
    end

      context 'on RedHat' do
        let :params do
          {
            'service_definition' => '/etc/systemd/system/kapacitor.service',
            'configuration_path' => '/etc/kapacitor',
            'configuration_file' => 'kapacitor.conf',
            'configuration_template' => 'kapacitor/kapacitor.conf.erb',
            'service_defaults' => '/etc/default/kapacitor',
            'service_default_template' => 'kapacitor/service-defaults.erb',
            'service_definition_template' => 'kapacitor/systemd.service.erb',
            'data_dir' => '/var/lib/kapacitor',
            'logging_file' => '/var/log/kapacitor/kapacitor.log',
            'load_dir' => '/etc/kapacitor/load',
            'replay_dir' => '/var/lib/kapacitor/replay',
            'task_dir' => '/var/lib/kapacitor/tasks',
            'storage_boltdb' => '/var/lib/kapacitor/kapacitor.db',
            'hostname' => 'localhost',
            'data_dir_manage' => 'directory',
            'skip_config_overrides' => false,
            'default_retention_policy' => '',
            'config_override_enabled' => true,
            'logging_file_manage' => 'present',
            'logging_level' => 'INFO',
            'load_enabled' => true,
            'load_dir_manage' => 'directory',
            'replay_dir_manage' => 'directory',
            'task_dir_manage' => 'directory',
            'task_snapshot_interval' => '60s',
            'storage_boltdb_manage' => 'present',
            'user' => 'foo',
            'group' => 'bar',
            'configuration_http' => {},
            'configuration_http_obligatory' => {
              'bind-address' => ':9092',
              'log-enabled' => true,
              'write-tracing' => false,
              'pprof-enabled' => false,
              'https-enabled' => false,
            },
            'configuration_tls' => {},
            'configuration_deadman' => {},
            'configuration_influxdb' => {},
            'configuration_kubernetes' => {},
            'configuration_smtp' => {},
            'configuration_snmptrap' => {},
            'configuration_opsgenie' => {},
            'configuration_opsgenie2' => {},
            'configuration_victorops' => {},
            'configuration_pagerduty' => {},
            'configuration_pagerduty2' => {},
            'configuration_pushover' => {},
            'configuration_httppost' => {},
            'configuration_slack' => {},
            'configuration_telegram' => {},
            'configuration_hipchat' => {},
            'configuration_kafka' => {},
            'configuration_alerta' => {},
            'configuration_sensu' => {},
            'configuration_reporting' => {},
            'configuration_stats' => {},
            'configuration_udf' => {},
            'configuration_talk' => {},
            'configuration_mqtt' => {},
            'configuration_swarm' => {},
            'configuration_collectd' => {},
            'configuration_opentsdb' => {},
            'configuration_scraper' => {},
            'configuration_azure' => {},
            'configuration_consul' => {},
            'configuration_dns' => {},
            'configuration_ec2' => {},
            'configuration_file_discovery' => {},
            'configuration_gce' => {},
            'configuration_marathon' => {},
            'configuration_nerve' => {},
            'configuration_serverset' => {},
            'configuration_static_discovery' => {},
            'configuration_triton' => {},
          }
        end

        it do
          if facts[:os]['family'] == 'RedHat'
            is_expected.to contain_file('/etc/systemd/system/kapacitor.service')
          end
        end
      end
    end
  end
end
