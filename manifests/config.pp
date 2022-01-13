# @summary Manages directories and files; service defaults
#
# @example
#   include kapacitor::config
class kapacitor::config inherits kapacitor {
  $template_http = deep_merge($configuration_http_obligatory, $configuration_http)

  file { $configuration_path:
    ensure => $kapacitor::ensure ? {
      'absent' => 'absent',
      default  => 'directory'
    },
    force  => true,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  -> file { "${configuration_path}/${configuration_file}":
    ensure  => $kapacitor::ensure ? {
      'absent' => 'absent',
      default  => 'present'
    },
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($configuration_template),
  }

  -> file { $service_defaults:
    ensure  => $kapacitor::ensure ? {
      'absent' => 'absent',
      default  => 'present'
    },
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_default_template),
  }

  -> file { $service_definition:
    ensure  => $kapacitor::ensure ? {
      'absent' => 'absent',
      default  => 'present'
    },
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_definition_template),
  }

  file { $data_dir:
    ensure => $kapacitor::ensure ? {
      'absent' => 'absent',
      default  => $data_dir_manage
    },
    force  => true,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { $logging_file:
    ensure => $kapacitor::ensure ? {
      'absent' => 'absent',
      default  => $logging_file_manage
    },
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { $load_dir:
    ensure => $kapacitor::ensure ? {
      'absent' => 'absent',
      default  => $load_dir_manage
    },
    force  => true,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { $replay_dir:
    ensure => $kapacitor::ensure ? {
      'absent' => 'absent',
      default  => $replay_dir_manage
    },
    force  => true,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { $task_dir:
    ensure => $kapacitor::ensure ? {
      'absent' => 'absent',
      default  => $task_dir_manage
    },
    force  => true,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { $storage_boltdb:
    ensure => $kapacitor::ensure ? {
      'absent' => 'absent',
      default  => $storage_boltdb_manage
    },
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }
}
