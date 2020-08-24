# include ::kapacitor

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
  configuration_http     => {
    'auth-enabled' => true,
  },
  configuration_tls      => {
    ciphers       => [
      'TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305',
      'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256',
    ],
    'min-version' => 'tls1.2',
    'max-version' => 'tls1.2',
  },
}
