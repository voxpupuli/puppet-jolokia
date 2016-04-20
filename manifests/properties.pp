# == Define jolokia::config
#
# This class is called from jolokia for service config.
#

define jolokia::config (
  $app        = $title,
  $ensure     = 'file',
  $properties = {},
) {
  $props_str = $properties.join_keys_to_values('=').join("\n")
  file { "${::jolokia::config_dir}/${app}.properties":
    ensure  => $ensure,
    content => $props_str,
  }
}
