# @summary Manages package, group, and user
#
# @example
#   include kapacitor::install
class kapacitor::install (
  String $group = $kapacitor::group,
  Boolean $group_system = $kapacitor::group_system,
  String $user = $kapacitor::user,
  Boolean $user_system = $kapacitor::user_system,
  Boolean $user_manage_home = $kapacitor::user_manage_home,
  String $user_home = $kapacitor::user_home,
){

  group { $group:
    ensure => present,
    system => $group_system,
  }

  user { $user:
    ensure     => present,
    gid        => $group,
    home       => "${user_home}${user}",
    managehome => $user_manage_home,
    system     => $user_system,
    require    => Group[$group],
  }
}
