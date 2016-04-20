# == Define jolokia::config
#
# This define allows creating arbitrary properties files for each
# application.
#

define jolokia::config (
  String                 $app        = $title,
  Enum['file', 'absent'] $ensure     = 'file',
  Hash                   $properties = {},
) {
  $disclaimer = "# This file is controlled by puppet\n# LOCAL CHANGES WILL BE OVERWRITTEN\n#"
  $props_str = $properties.join_keys_to_values('=').join("\n")

  file { "${::jolokia::config_dir}/${app}.properties":
    ensure  => $ensure,
    content => "${disclaimer}\n${props_str}\n",
  }
}
