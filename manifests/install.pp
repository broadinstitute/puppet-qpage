# == Class: qpage::install
#
# This class takes care of all necessary package installations
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
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
# === Examples
#
#  class { 'qpage':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2017
#
class qpage::install {

    package { $qpage::_package_name:
        ensure   => $qpage::package_ensure,
        name     => $qpage::_package_name,
        provider => $qpage::package_provider,
        before   => Service['qpage_service']
    }
}
