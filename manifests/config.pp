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
){

  file { $configuration_path:
    ensure => $configuration_path_manage,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  -> file { "${configuration_path}/${configuration_file}":
      owner => 'root',
      group => 'root',
      mode  => '0644'
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
}
