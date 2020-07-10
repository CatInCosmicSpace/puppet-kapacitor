# @summary Manages gpg key information and repository, if necessary
#
# @example
#   include kapacitor::repo
class kapacitor::repo (
  Boolean $manage_repo = $kapacitor::manage_repo,
  String $ensure = $kapacitor::ensure,
  String $package_name = $kapacitor::package_name,
  String $repo_location = $kapacitor::repo_location,
  String $repo_type = $kapacitor::repo_type,
){

  if $facts['os']['family'] == 'Debian' {
    if $manage_repo {
      apt::source { 'influxdata':
        comment  => 'InfluxData repository',
        location => "${repo_location}${facts['os']['name'].downcase}",
        release  => $facts[os][distro][codename],
        repos    => $repo_type,
        key      => {
          'id'     => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
          'source' => "${repo_location}influxdb.key",
        },
      }
    }
    include apt
    Class['::apt::update'] -> Package[$package_name]
    package { $package_name:
      ensure => $ensure,
    }
  }

  if $facts['os']['name'] == 'CentOS' {
    if $manage_repo {
      yumrepo { 'influxdata':
        name     => 'influxdata',
        descr    => 'InfluxData Repository',
        enabled  => 1,
        baseurl  => "${repo_location}rhel/${facts['os']['release']['major']}/${facts['os']['architecture']}/${repo_type}",
        gpgkey   => "${repo_location}influxdb.key",
        gpgcheck => 1,
      }
    }
    package { $package_name:
      ensure => $ensure,
    }
  }
}
