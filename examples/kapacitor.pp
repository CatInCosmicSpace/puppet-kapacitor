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

