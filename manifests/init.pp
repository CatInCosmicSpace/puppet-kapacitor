# @summary Manages a Kapacitor
#
# @example
#   include kapacitor
class kapacitor (
  String $key_resource = '',
  String $resource = '',
  String $software = 'influxdata',
  Enum['present', 'absent'] $gpg_manage = 'present',
  String $gpg_id = '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
  String $gpg_server = 'eu.pool.sks-keyservers.net',
  String $gpg_source = 'https://repos.influxdata.com/.influxdb.key',

  Enum['present', 'absent'] $repository_manage = 'present',
  String $repos_comment = 'Kapacitor repository',
  String $repos_location = 'https://repos.influxdata.com/ubuntu',
  String $repos_release ='%{::os.distro.codename}',
  String $repos = 'stable',
  Boolean $repos_src = false,
  Boolean $repos_bin = true,
  Enum['1', '0'] $repos_gpgcheck = '1',
  Enum['1', '0'] $repos_enable = '1',
  Boolean $manage_repo = false,

  String $package= 'kapacitor',
  Enum['present', 'absent'] $package_manage= 'present',

){

  include ::kapacitor::repo
  include ::kapacitor::install
  include ::kapacitor::config
  contain ::kapacitor::service

  Class['kapacitor::repo'] ~> Class['kapacitor::install']
  Class['kapacitor::install'] ~> Class['kapacitor::config', 'kapacitor::service']

}
