include ::kapacitor

# is there another influxdata module, which handles already the gpg key and the repo
class { 'kapacitor':
  manage_repo => false,
}

# kapacitor handels the gpg key and the repo
class { 'kapacitor':
  manage_repo => true,
}

# configure kapacitor with influxdb
class { 'kapacitor':
  manage_repo            => false,
  configuration_influxdb => {
    influxdb => [{
      'name'     => 'localhost',
      'password' => '',
      'timeout'  => 0,
      'urls'     => ['http://localhost:8086',],
      'username' => '',
      'default'  => true,
      'enabled'  => true,
    }],
  },
}
