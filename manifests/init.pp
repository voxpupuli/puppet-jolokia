# install, and optionally configure jolokia
class jolokia (
  String $jvm_agent_ensure = 'present',
  String $jvm_agent_name   = 'jolokia-jvm-agent',
  String $config_dir       = '/etc/jolokia',
) {

  file { $config_dir:
    ensure => directory,
  }
  contain jolokia::install
}
