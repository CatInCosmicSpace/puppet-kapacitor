# @summary Manages a Kapacitor
#
# @example
#   include kapacitor
class kapacitor (
  Boolean $manage_repo = true,
  String $package_name = $kapacitor::params::package_name,
  String $ensure_package = $kapacitor::params::ensure_package,
  String $repo_location = $kapacitor::params::repo_location,
  String $repo_type = $kapacitor::params::repo_type,

  String $group = $kapacitor::params::group,
  Enum['present', 'absent'] $group_manage = $kapacitor::params::group_manage,
  Boolean $group_system = $kapacitor::params::group_system,
  String $user = $kapacitor::params::user,
  Enum['present', 'absent'] $user_manage = $kapacitor::params::user_manage,
  Boolean $user_system = $kapacitor::params::user_system,
  Boolean $user_manage_home = $kapacitor::params::user_manage_home,
  String $user_home = $kapacitor::params::user_home,

  String $configuration_path = $kapacitor::params::configuration_path,
  Enum['directory', 'absent'] $configuration_path_manage = $kapacitor::params::configuration_path_manage,
  String $configuration_file = $kapacitor::params::configuration_file,
  Enum['present', 'absent'] $configuration_file_manage = $kapacitor::params::configuration_file_manage,
  String $configuration_template = $kapacitor::params::configuration_template,

  String $service_defaults = $kapacitor::params::service_defaults,
  Enum['present', 'absent'] $service_defaults_manage = $kapacitor::params::service_defaults_manage,
  String $service_default_template = $kapacitor::params::service_default_template,
  String $service_definition = $kapacitor::params::service_definition,
  Enum['present', 'absent'] $service_definition_manage = $kapacitor::params::service_definition_manage,
  String $service_definition_template = $kapacitor::params::service_definition_template,
  String $service_name = $kapacitor::params::service_name,
  String $service_provider = $kapacitor::params::service_provider,
  Enum['running', 'stopped'] $service_ensure = $kapacitor::params::service_ensure,
  Boolean $service_enable = $kapacitor::params::service_enable,
  Boolean $service_has_status = $kapacitor::params::service_has_status,
  Boolean $service_has_restart = $kapacitor::params::service_has_restart,
  Boolean $manage_service = $kapacitor::params::manage_service,
  Boolean $notify_service = $kapacitor::params::notify_service,

  String $hostname = 'localhost',
  String $data_dir = '/var/lib/kapacitor',
  Enum['directory', 'absent'] $data_dir_manage = 'directory',
  Boolean $skip_config_overrides = false,
  String $default_retention_policy = '',
  String $bind_address = ':9092',
  Boolean $log_enabled = true,
  Boolean $write_tracing = false,
  Boolean $pprof_enabled = false,
  Boolean $https_enabled = false,
  String $https_certificate = '/etc/ssl/kapacitor.pem',
  Enum['present', 'absent'] $https_certificate_manage = 'present',
  String $https_private_key = '',
  Boolean $config_override_enabled = true,
  String $logging_file = '/var/log/kapacitor/kapacitor.log',
  Enum['present', 'absent'] $logging_file_manage = 'present',
  String $logging_level = 'INFO',
  Boolean $load_enabled = true,
  String $load_dir = '/etc/kapacitor/load',
  Enum['directory', 'absent'] $load_dir_manage = 'directory',
  String $replay_dir = '/var/lib/kapacitor/replay',
  Enum['directory', 'absent'] $replay_dir_manage = 'directory',
  String $task_dir = '/var/lib/kapacitor/tasks',
  Enum['directory', 'absent'] $task_dir_manage = 'directory',
  String $task_snapshot_interval = '60s',
  String $storage_boltdb = '/var/lib/kapacitor/kapacitor.db',
  Enum['present', 'absent'] $storage_boltdb_manage = 'present',

  Hash $configuration_influxdb = $kapacitor::params::configuration_influxdb,
  Hash $configuration_kubernetes = $kapacitor::params::configuration_kubernetes,
  Hash $configuration_smtp = $kapacitor::params::configuration_smtp,
  Hash $configuration_snmptrap = $kapacitor::params::configuration_snmptrap,
  Hash $configuration_opsgenie = $kapacitor::params::configuration_opsgenie,
  Hash $configuration_victorops = $kapacitor::params::configuration_victorops,
  Hash $configuration_pagerduty = $kapacitor::params::configuration_pagerduty,
  Hash $configuration_pushover = $kapacitor::params::configuration_pushover,
  Hash $configuration_httppost = $kapacitor::params::configuration_httppost,
  Hash $configuration_slack = $kapacitor::params::configuration_slack,
  Hash $configuration_telegram = $kapacitor::params::configuration_telegram,
  Hash $configuration_hipchat = $kapacitor::params::configuration_hipchat,
  Hash $configuration_kafka = $kapacitor::params::configuration_kafka,
  Hash $configuration_alerta = $kapacitor::params::configuration_alerta,
  Hash $configuration_sensu = $kapacitor::params::configuration_sensu,
  Hash $configuration_reporting = $kapacitor::params::configuration_reporting,
  Hash $configuration_stats = $kapacitor::params::configuration_stats,
  Hash $configuration_udf = $kapacitor::params::configuration_udf,
  Hash $configuration_talk = $kapacitor::params::configuration_talk,
  Hash $configuration_mqtt = $kapacitor::params::configuration_mqtt,
  Hash $configuration_swarm = $kapacitor::params::configuration_swarm,
  Hash $configuration_collectd = $kapacitor::params::configuration_collectd,
  Hash $configuration_opentsdb = $kapacitor::params::configuration_opentsdb,
  Hash $configuration_scraper = $kapacitor::params::configuration_scraper,
  Hash $configuration_azure = $kapacitor::params::configuration_azure,
  Hash $configuration_consul = $kapacitor::params::configuration_consul,
  Hash $configuration_dns = $kapacitor::params::configuration_dns,
  Hash $configuration_ec2 = $kapacitor::params::configuration_ec2,
  Hash $configuration_file_discovery = $kapacitor::params::configuration_file_discovery,
  Hash $configuration_gce = $kapacitor::params::configuration_gce,
  Hash $configuration_marathon = $kapacitor::params::configuration_marathon,
  Hash $configuration_nerve = $kapacitor::params::configuration_nerve,
  Hash $configuration_serverset = $kapacitor::params::configuration_serverset,
  Hash $configuration_static_discovery = $kapacitor::params::configuration_static_discovery,
  Hash $configuration_triton = $kapacitor::params::configuration_triton,

)
  inherits kapacitor::params
{

  include ::kapacitor::repo
  include ::kapacitor::install
  include ::kapacitor::config
  contain ::kapacitor::service

  Class['kapacitor::repo'] ~> Class['kapacitor::install']
  Class['kapacitor::install'] ~> Class['kapacitor::config', 'kapacitor::service']

  if $notify_service {
    Class['kapacitor::config']
    ~> Class['kapacitor::service']
  }
}
