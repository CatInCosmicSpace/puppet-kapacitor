# @summary Manages the service
#
# @example
#   include kapacitor::service
class kapacitor::service (
  String $service_name = $kapacitor::service_name,
  Enum['running', 'stopped'] $service_ensure = $kapacitor::service_ensure,
  Boolean $service_enable = $kapacitor::service_enable,
  Boolean $service_has_status = $kapacitor::service_has_status,
  Boolean $service_has_restart = $kapacitor::service_has_restart,
  String $service_provider = $kapacitor::service_provider,
  Boolean $manage_service = $kapacitor::manage_service,
){
  if $manage_service {
    service { $service_name:
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasstatus  => $service_has_status,
      hasrestart => $service_has_restart,
      provider   => $service_provider,
    }
  }
}

