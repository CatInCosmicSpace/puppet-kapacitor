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

  configuration_smtp     => {
      'enabled'  => true,
      'host'     => 'mail.kogito.network',
      'port'     => 25,
      'username' => 'admin@kogito.network',
      'password' => 'c951iPM7VaAtqAxBpqMAEhwc',
      'from'     => 'admin@kogito.network',
      'to'       => ['daniel@kogito.network', 'uwoth@kogito.network',],
    },

  configuration_stats    => {
  'enabled'          => true,
  'stats-interval'   => '10s',
  'database'         => '_kapacitor',
  'retention-policy' => 'autogen',
  },

}

