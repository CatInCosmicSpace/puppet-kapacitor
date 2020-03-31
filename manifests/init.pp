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
  Boolean $manage_repo = true,

  String $package= 'kapacitor',
  Enum['present', 'absent'] $package_manage= 'present',

  String $group = 'kapacitor',
  Enum['present', 'absent'] $group_manage = 'present',
  Boolean $group_system = true,
  String $user = 'kapacitor',
  Enum['present', 'absent'] $user_manage = 'present',
  Boolean $user_system = true,
  Boolean $user_manage_home = true,
  String $user_home = '/var/lib/',

  String $configuration_path = '/etc/kapacitor',
  Enum['directory', 'absent'] $configuration_path_manage = 'directory',
  String $configuration_file = 'kapacitor.conf',
  Enum['present', 'absent'] $configuration_file_manage = 'present',
  String $configuration_template= 'kapacitor/kapacitor.conf.erb',

  String $service_defaults = '/etc/default/kapacitor',
  Enum['present', 'absent'] $service_defaults_manage = 'present',
  String $service_default_template = 'kapacitor/service-defaults.erb',
  String $service_definition = '/lib/systemd/system/kapacitor.service',
  Enum['present', 'absent'] $service_definition_manage = 'present',
  String $service_definition_template = 'kapacitor/systemd.service.erb',
  String $service_name = 'kapacitor',
  String $service_provider = 'systemd',
  Enum['running', 'absent'] $service_manage = 'running',
  Boolean $service_enable = true,
  Boolean $service_has_status = true,
  Boolean $service_has_restart = true,

  Hash $settings = {},

){

  include ::kapacitor::repo
  include ::kapacitor::install
  include ::kapacitor::config
  contain ::kapacitor::service

  Class['kapacitor::repo'] ~> Class['kapacitor::install']
  Class['kapacitor::install'] ~> Class['kapacitor::config', 'kapacitor::service']

  $settings = {
    'influxdb' => [{
      'enabled'  => true,
      'default'  => true,
      'name'     => 'localhost',
      'urls'     => [ 'http://localhost:8086' ],
      'username' => '',
      'password' => '',
      'timeout'  => 0,
    }]
  }
}
