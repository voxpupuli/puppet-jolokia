# install, and optionally configure jolokia
class jolokia (
  $jvm_agent_ensure = 'present',
  $jvm_agent_name   = 'jolokia-jvm-agent',
  $config_dir       = '/etc/jolokia',
) {

  file { $config_dir:
    ensure => directory,
  }
  contain ::jolokia::install
}
