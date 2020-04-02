# @summary A short summary of the purpose of this class
#
# A description of what this class does
# @example
#   include kapacitor::tick
class kapacitor::tick (
  String $path = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
){

  file { '/etc/kapacitor/load/templates':
    ensure =>  'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  -> file { '/etc/kapacitor/load/templates/generic_mean_alert.tick':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => template('kapacitor/generic_alert_template.erb'),
  }

#  kapacitor define-template generic_mean_alert -tick path/to/template_script.tick#
#./kapacitor -url http://username:password@MYSERVER:9092 show TASKNAME
  -> exec {"define-template_${'generic_mean_alert.tick'}":
    path    => $path,
    command =>
      'kapacitor define-template generic_mean_alert -tick /etc/kapacitor/load/templates/generic_mean_alert.tick',
  }

  -> file { '/etc/kapacitor/load/templates/cpu_vars.json':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => template('kapacitor/cpu_vars.erb'),
  }
# kapacitor define cpu_alert -template generic_mean_alert -vars cpu_vars.json -dbrp telegraf.autogen
  -> exec {"define-task}${'cpu_alert'}":
    path    => $path,
    command =>
      'kapacitor define cpu_alert -template generic_mean_alert -vars /etc/kapacitor/load/templates/cpu_vars.json -dbrp telegraf.autogen',
  }
}
