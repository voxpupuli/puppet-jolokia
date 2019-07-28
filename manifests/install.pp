# == Class jolokia::install
#
# This class is called from jolokia for install.
#
class jolokia::install {

  package { 'jolokia-agent':
    ensure => $jolokia::jvm_agent_ensure,
    name   => $jolokia::jvm_agent_name,
  }
}
