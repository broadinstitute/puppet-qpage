# == Class: qpage::params
#
# The default parameters for the qpage class
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2017
#
class qpage::params {
  # Service settings
  $config_mode   = '0644'
  $config_owner   = 'root'

  # Config settings
  $administrator = undef
  $forcehostname = 'false'  # lint:ignore:quoted_booleans
  $groups        = {}
  $identtimeout  = '0'
  $include       = undef
  $lockdir       = undef
  $modems        = {}
  $pagers        = {}
  $service_defs  = {}
  $snpptimeout   = '60'
  $synchronous   = 'true'  # lint:ignore:quoted_booleans

  case $::osfamily {
    'FreeBSD': {
      # Service settings
      $config_group     = 'wheel'
      $config_path      = '/usr/local/etc/qpage.conf'
      $package_name     = 'qpage'
      $package_provider = 'pkgng'
      $service_name     = 'qpage'

      # Config settings
      $pidfile          = '/var/run/qpage'
      $queuedir         = '/var/spool/qpage'
      $sigfile          = '/dev/null'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }
}
