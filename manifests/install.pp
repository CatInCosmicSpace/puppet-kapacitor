# @summary Manages package, group, and user
#
# @example
#   include kapacitor::install
class kapacitor::install (
  String $package= $kapacitor::package,
  Enum['present', 'absent'] $package_manage = $kapacitor::package_manage,
  String $group = $kapacitor::group,
  Enum['present', 'absent'] $group_manage = $kapacitor::group_manage,
  Boolean $group_system = $kapacitor::group_system,
  String $user = $kapacitor::user,
  Enum['present', 'absent'] $user_manage = $kapacitor::user_manage,
  Boolean $user_system = $kapacitor::user_system,
  Boolean $user_manage_home = $kapacitor::user_manage_home,
  String $user_home = $kapacitor::user_home,
){
  package { $package:
    ensure => $package_manage
  }

  group { $group:
    ensure => $group_manage,
    system => $group_system,
  }

  user { $user:
    ensure     => $user_manage,
    gid        => $group,
    home       => "${user_home}${user}",
    managehome => $user_manage_home,
    system     => $user_system,
    require    => Group[$group],
  }
}
