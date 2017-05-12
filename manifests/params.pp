# == Class: qpage::params
#
# The default parameters for the qpage class
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
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
    $forcehostname = true
    $identtimeout  = 0
    $modems        = {}
    $pagers        = {}
    $service_defs  = {}

    case $::osfamily {
        'FreeBSD': {
            # include ::pkgng

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
