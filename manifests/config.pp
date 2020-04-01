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
  Boolean $skip_config_overrides = $kapacitor::skip_config_overrides,
  String $default_retention_policy = $kapacitor::default_retention_policy,
  String $bind_address = $kapacitor::bind_address,
  Boolean $log_enabled = $kapacitor::log_enabled,
  Boolean $write_tracing = $kapacitor::write_tracing,
  Boolean $pprof_enabled = $kapacitor::pprof_enabled,
  Boolean $https_enabled = $kapacitor::https_enabled,
  String $https_certificate = $kapacitor::https_certificate,
  Enum['present', 'absent'] $https_certificate_manage = $kapacitor::https_certificate_manage,
  String $https_private_key = $kapacitor::https_private_key,
  Boolean $config_override_enabled = $kapacitor::config_override_enabled,
  String $logging_file = $kapacitor::logging_file,
  Enum['present', 'absent'] $logging_file_manage = $kapacitor::logging_file_manage,
  String $logging_level = $kapacitor::logging_level,
  Boolean $load_enabled = $kapacitor::load_enabled,
  String $load_dir = $kapacitor::load_dir,
  Enum['directory', 'absent'] $load_dir_manage = $kapacitor::load_dir_manage,
  String $replay_dir = $kapacitor::replay_dir,
  Enum['directory', 'absent'] $replay_dir_manage = $kapacitor::replay_dir_manage,
  String $task_dir = $kapacitor::task_dir,
  Enum['directory', 'absent'] $task_dir_manage = $kapacitor::task_dir_manage,
  String $task_snapshot_interval = $kapacitor::task_snapshot_interval,
  String $storage_boltdb = $kapacitor::storage_boltdb,
  Enum['present', 'absent'] $storage_boltdb_manage = $kapacitor::storage_boltdb_manage,
  Hash $configuration = $kapacitor::configuration,
  String $user = $kapacitor::user,
  String $group = $kapacitor::group,
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
