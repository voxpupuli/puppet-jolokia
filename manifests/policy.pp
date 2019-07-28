# == Define jolokia::policy
#
# This define allows policy files for *host-based* *authorization*
# Usually one per host should suffice, unless you require distinct
# *authentication*.
#

define jolokia::policy (
  String                 $app           = $title,
  Enum['file', 'absent'] $ensure        = 'file',
  Array[String]          $allowed_hosts = ['127.0.0.1', '::1'],
) {

  $params = { 'allowed_hosts' => $allowed_hosts }
  file { "${jolokia::config_dir}/${app}.xml":
    ensure  => $ensure,
    content => epp("${module_name}/policy.xml.epp", $params),
  }
}
