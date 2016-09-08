#### Table of Contents

1. [Overview](#overview)
3. [Setup Requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This Puppet 4.+ module installs and helps configure
[jolokia](https://jolokia.org/) (jvm) agents.


### Setup Requirements

Currently, this module expects you to provide a package for your platform which
it then installs. We generally *highly* recommend this approach, because it
makes life easier.

### Usage

```puppet
include ::jolokia
```

After this statement you should be able to extend your JVMs' `JAVA_OPTS` with

```
-javaagent:/usr/lib/java/jolokia-jvm-agent.jar=host=0.0.0.0
```

More more complex configurations can be put into a properties file. We provide
a wrapper for that:

```puppet
$props = {
  'host' => '*',
  'policyLocation' => 'file:///etc/jolokia/lolsecurity.xml',
}

jolokia::config { 'puppetserver':
  properties => $props + { 'port' => '7887' }
}
jolokia::config { 'puppetdb':
  properties => $props + { 'port' => '7889' }
}
```

We also provide a wrapper for creating policy files. However, currently it's
restricted host-based authorization only:

```puppet
jolokia::policy { 'lolsecurity':
  allowed_hosts => [ '1.1.1.1', '::1' ]
}
```

## Reference

### jolokia

This class is the main driver for the installation.

```puppet
  String $jvm_agent_ensure = 'present',
  String $jvm_agent_name   = 'jolokia-jvm-agent',
  String $config_dir       = '/etc/jolokia',
```

### jolokia::config

This define allows creating arbitrary properties files for each application.

```puppet
  String                 $app        = $title,
  Enum['file', 'absent'] $ensure     = 'file',
  Hash                   $properties = {},
```

### jolokia::policy

This define allows policy files for *host-based* *authorization* Usually one
per host should suffice, unless you require distinct *authentication*.

```puppet
  String                 $app           = $title,
  Enum['file', 'absent'] $ensure        = 'file',
  Array[String]          $allowed_hosts = ['127.0.0.1', '::1'],
```

## Limitations

* currently we expect you to provide your own package(s)
* policy configuration only creates host-based authorization
* our documentation is sad

##Development

### Running tests

This project contains tests for [rspec-puppet](http://rspec-puppet.com/).

Quickstart:

```bash
gem install bundler
bundle install --path .vendor/
bundle exec rake test
```
