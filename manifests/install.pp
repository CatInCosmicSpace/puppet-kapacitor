# @summary Manages package
#
# @example
#   include kapacitor::install
class kapacitor::install (
  String $ensure       = $kapacitor::ensure,
  String $package_name = $kapacitor::package_name,
) {
  case $facts['os']['family'] {
    'Debian': {
      include apt
      Class['::apt::update'] -> Package[$package_name]
    }
    'RedHat': {
      Yumrepo['influxdata'] -> Package[$package_name]
    }
    default: {
      # do nothing
    }
  }

  package { $package_name:
    ensure => $ensure,
  }
}
