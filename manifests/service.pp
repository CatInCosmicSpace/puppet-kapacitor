# @summary Manages the service
#
# @example
#   include kapacitor::service
class kapacitor::service (
  String $service_name = $kapacitor::service_name,
  Enum['running', 'absent'] $service_manage = $kapacitor::service_manage,
  Boolean $service_enable = $kapacitor::service_enable,
  Boolean $service_has_status = $kapacitor::service_has_status,
  Boolean $service_has_restart = $kapacitor::service_has_restart,
  String $service_provider = $kapacitor::service_provider,
  String $service_definition = $kapacitor::service_definition,
  String $service_defaults = $kapacitor::service_defaults,
  String $configuration_path = $kapacitor::configuration_path,
  String $configuration_file = $kapacitor::configuration_file,
  String $package = $kapacitor::package,
){
  service { $service_name:
    ensure     => $service_manage,
    enable     => $service_enable,
    hasstatus  => $service_has_status,
    hasrestart => $service_has_restart,
    provider   => $service_provider,
    subscribe  => [
      Concat["${configuration_path}/${configuration_file}"],
      File[$service_definition],
      File[$service_defaults],
      Package[$package],
    ]
  }
}

