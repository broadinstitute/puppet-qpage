# == Class: qpage::install
#
# This class takes care of all necessary package installations
#
# === Variables
#
# [*qpage::package_ensure*]
#   In what state should we put the package (installed, absent, etc.)
#
# [*qpage::_package_name*]
#   The name of the package to install
#
# [*qpage::package_provider*]
#   The Puppet provider to use when installing the package
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
    if ! defined(Class['qpage']) {
        fail('You must include the qpage base class before using any qpage defined resources')
    }

    package { 'qpage_package':
        ensure   => $::qpage::package_ensure,
        name     => $::qpage::_package_name,
        provider => $::qpage::package_provider,
    }
}
