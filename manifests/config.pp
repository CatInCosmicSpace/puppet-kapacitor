# @summary Manages directories and files; service defaults
#
# @example
#   include kapacitor::config
class kapacitor::config inherits kapacitor {
  $template_http = deep_merge($configuration_http_obligatory, $configuration_http)

  file { $configuration_path:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  -> file { "${configuration_path}/${configuration_file}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($configuration_template),
  }

  -> file { $service_defaults:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_default_template),
  }

  -> file { $service_definition:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_definition_template),
  }

  file { $data_dir:
    ensure => $data_dir_manage,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { $logging_file:
    ensure => $logging_file_manage,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { $load_dir:
    ensure => $load_dir_manage,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { $replay_dir:
    ensure => $replay_dir_manage,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { $task_dir:
    ensure => $task_dir_manage,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { $storage_boltdb:
    ensure => $storage_boltdb_manage,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }
}
