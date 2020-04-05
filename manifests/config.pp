# @summary Manages directories and files; service defaults
#
# @example
#   include kapacitor::config
class kapacitor::config (
  String $configuration_path = $kapacitor::configuration_path,
  Enum['directory', 'absent'] $configuration_path_manage = $kapacitor::configuration_path_manage,
  String $configuration_file = $kapacitor::configuration_file,
  Enum['present', 'absent'] $configuration_file_manage = $kapacitor::configuration_file_manage,
  String $configuration_template= $kapacitor::configuration_template,
  String $service_defaults = $kapacitor::service_defaults,
  Enum['present', 'absent'] $service_defaults_manage = $kapacitor::service_defaults_manage,
  String $service_default_template = $kapacitor::service_default_template,
  String $service_definition = $kapacitor::service_definition,
  Enum['present', 'absent'] $service_definition_manage = $kapacitor::service_definition_manage,
  String $service_definition_template = $kapacitor::service_definition_template,
  String $hostname = $kapacitor::hostname,
  String $data_dir = $kapacitor::data_dir,
  Enum['directory', 'absent'] $data_dir_manage = $kapacitor::data_dir_manage,
  String $https_certificate = $kapacitor::https_certificate,
  Enum['present', 'absent'] $https_certificate_manage = $kapacitor::https_certificate_manage,
  String $logging_file = $kapacitor::logging_file,
  Enum['present', 'absent'] $logging_file_manage = $kapacitor::logging_file_manage,
  String $load_dir = $kapacitor::load_dir,
  Enum['directory', 'absent'] $load_dir_manage = $kapacitor::load_dir_manage,
  String $replay_dir = $kapacitor::replay_dir,
  Enum['directory', 'absent'] $replay_dir_manage = $kapacitor::replay_dir_manage,
  String $task_dir = $kapacitor::task_dir,
  Enum['directory', 'absent'] $task_dir_manage = $kapacitor::task_dir_manage,
  String $storage_boltdb = $kapacitor::storage_boltdb,
  Enum['present', 'absent'] $storage_boltdb_manage = $kapacitor::storage_boltdb_manage,
  String $user = $kapacitor::user,
  String $group = $kapacitor::group,
  Hash $configuration_influxdb = $kapacitor::configuration_influxdb,
  Hash $configuration_kubernetes = $kapacitor::configuration_kubernetes,
  Hash $configuration_smtp = $kapacitor::configuration_smtp,
  Hash $configuration_snmptrap = $kapacitor::configuration_snmptrap,
  Hash $configuration_opsgenie = $kapacitor::configuration_opsgenie,
  Hash $configuration_victorops = $kapacitor::configuration_victorops,
  Hash $configuration_pagerduty = $kapacitor::configuration_pagerduty,
  Hash $configuration_pushover = $kapacitor::configuration_pushover,
  Hash $configuration_httppost = $kapacitor::configuration_httppost,
  Hash $configuration_slack = $kapacitor::configuration_slack,
  Hash $configuration_telegram = $kapacitor::configuration_telegram,
  Hash $configuration_hipchat = $kapacitor::configuration_hipchat,
  Hash $configuration_kafka = $kapacitor::configuration_kafka,
  Hash $configuration_alerta = $kapacitor::configuration_alerta,
  Hash $configuration_sensu = $kapacitor::configuration_sensu,
  Hash $configuration_reporting = $kapacitor::configuration_reporting,
  Hash $configuration_stats = $kapacitor::configuration_stats,
  Hash $configuration_udf = $kapacitor::configuration_udf,
  Hash $configuration_talk = $kapacitor::configuration_talk,
  Hash $configuration_mqtt = $kapacitor::configuration_mqtt,
  Hash $configuration_swarm = $kapacitor::configuration_swarm,
  Hash $configuration_collectd = $kapacitor::configuration_collectd,
  Hash $configuration_opentsdb = $kapacitor::configuration_opentsdb,
  Hash $configuration_scraper = $kapacitor::configuration_scraper,
  Hash $configuration_azure = $kapacitor::configuration_azure,
  Hash $configuration_consul = $kapacitor::configuration_consul,
  Hash $configuration_dns = $kapacitor::configuration_dns,
  Hash $configuration_ec2 = $kapacitor::configuration_ec2,
  Hash $configuration_file_discovery = $kapacitor::configuration_file_discovery,
  Hash $configuration_gce = $kapacitor::configuration_gce,
  Hash $configuration_marathon = $kapacitor::configuration_marathon,
  Hash $configuration_nerve = $kapacitor::configuration_nerve,
  Hash $configuration_serverset = $kapacitor::configuration_serverset,
  Hash $configuration_static_discovery = $kapacitor::configuration_static_discovery,
  Hash $configuration_triton = $kapacitor::configuration_triton,
){

  file { $configuration_path:
    ensure => $configuration_path_manage,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  -> file { "${configuration_path}/${configuration_file}":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($kapacitor::configuration_template),
  }

  -> file { $service_defaults:
      ensure  => $service_defaults_manage,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($service_default_template),
  }

  -> file { $service_definition:
      ensure  => $service_definition_manage,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($service_definition_template),
  }

  -> file { $data_dir:
      ensure => $data_dir_manage,
      owner  => $user,
      group  => $group,
      mode   => '0755',
  }

  -> file { $https_certificate:
      ensure => $https_certificate_manage,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
  }

  -> file { $logging_file:
      ensure => $logging_file_manage,
      owner  => $user,
      group  => $group,
      mode   => '0755',
  }

  -> file { $load_dir:
      ensure => $load_dir_manage,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
  }

  -> file { $replay_dir:
      ensure => $replay_dir_manage,
      owner  => $user,
      group  => $group,
      mode   => '0755',
  }

  -> file { $task_dir:
      ensure => $task_dir_manage,
      owner  => $user,
      group  => $group,
      mode   => '0755',
  }

  -> file { $storage_boltdb:
      ensure => $storage_boltdb_manage,
      owner  => $user,
      group  => $group,
      mode   => '0755',
  }
}
