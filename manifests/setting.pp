# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @example
#   kapacitor::setting { 'setting': }
define kapacitor::setting (
  String $plugin_type = $title,
  Optional[Array] $options = undef,
) {

  include kapacitor

  file {"${kapacitor::configuration_path}/${kapacitor::configuration_file}.conf":
    content => inline_template("<%= require 'toml-rb'; TomlRB.dump({'settings'=>{'${plugin_type}'=>@options}}) %>"),
    require => Class['kapacitor::config'],
    notify  => Class['kapacitor::service'],
  }
}
