# Puppet module to manage Kapacitor

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with kapacitor](#setup)
   - [What kapacitor affects](#what-kapacitor-affects)
   - [Setup requirements](#setup-requirements)
   - [Beginning with kapacitor](#beginning-with-kapacitor)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

Installs, configures and manages the [Kapacitor](https://github.com/influxdata/kapacitor),
which processes, monitores, and alerts on time series data.

## Setup

### What kapacitor affects

Default configuration

- manages GPG key, repository (default: `manage_repo = true`)

  - default: `repo_location = https://repos.influxdata.com/` and `repo_type = 'stable'`

- manages package

- manages directories and configuration files (referring to templates)

  - `/etc/kapacitor/kapacitor.conf`

  - Debian: `/lib/systemd/system/kapacitor.service`
  - CentOs: `/etc/systemd/system/kapacitor.service`

  - `/etc/default/kapacitor`

- starts service "kapacitor" immediately (default: `manage_service = true`)

- does not handle user/group, because both are handled by the package

### Setup Requirements

This module requires the toml-rb gem. Add the gem eg. to the Gemfile.
For an extensive list of requirements, see `metadata.json`.

### Beginning with kapacitor

The module comes along with several configuration files (see templates).
Change configuration settings in according hiera level or by using hashes.

- `kapacitor.conf.erb`
- `service-defaults.erb` - adds empty file
- `systemd.service.erb`

## Usage

### Configuration

Please refer to [Kapacitor documentation](https://www.influxdata.com/time-series-platform/kapacitor/)
for the defaults used.

Change basic configuration setting via the according variables.
For topics like "kubernetes", "smtp", etc. use hiera or hashes.
"http" comes with an obligatory default setting, which is merged in case of:

```
Hash $configuration_http_obligatory = {
    'bind-address' => ':9092',
    'log-enabled' => true,
    'write-tracing' => false,
    'pprof-enabled' => false,
    'https-enabled' => false,
  }
```

### Other directories and bolt db

Manage and change the defaults

| parameter      |             default             |                             manage via |
| :------------- | :-----------------------------: | -------------------------------------: |
| data_dir       |       /var/lib/kapacitor        |     data_dir_manage [directory,absent] |
| load_dir       |       /etc/kapacitor/load       |     load_dir_manage [directory,absent] |
| replay_dir     |    /var/lib/kapacitor/replay    |   replay_dir_manage [directory,absent] |
| task_dir       |    /var/lib/kapacitor/tasks     |     task_dir_manage [directory,absent] |
| storage_boltdb | /var/lib/kapacitor/kapacitor.db | storage_boltdb_manage [present,absent] |

### In combination with other influxdata module

- when one of the other influxdata modules already handles GPG keys and repository

```
class { 'kapacitor':
  manage_repo => false,
}
```

- when kapacitor shall handle GPG keys and repository

```
class { 'kapacitor':
  manage_repo => true,
}
```

### Example

```
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
  }
}
```

## Reference

Please see document `REFERENCE.md`.

## Limitations

For an extensive list of supported operating systems, see `metadata.json`.

## Development

- pdk-version 1.18.1
- template-url pdk-default 1.18.1
- template-ref tags/1.18.1-0-g3d2e75c

## Release Notes/Contributors/Etc.

- module: kogitoapp-kapacitor
- version: 0.1.0
- author: Kogito UG <hello@kogito.network>
- summary: Module for configuring Kapacitor
- license: Apache-2.0
- source: https://github.com/kogitoapp/puppet-kapacitor
