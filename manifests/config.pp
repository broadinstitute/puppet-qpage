# == Class: qpage::config
#
# This class takes care of all necessary configuration
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2017
#
class qpage::config {

    if ! defined(Class['qpage']) {
        fail('You must include the qpage base class before using any qpage defined resources')
    }

    $administrator = $qpage::config_administrator
    $forcehostname = $qpage::config_forcehostname
    $identtimeout  = $qpage::config_identtimeout
    $modems        = $qpage::config_modems
    $pagers        = $qpage::config_pagers
    $pidfile       = $qpage::config_pidfile
    $queuedir      = $qpage::config_queuedir
    $service_defs  = $qpage::config_service_defs
    $sigfile       = $qpage::config_sigfile

    file { 'qpage_config':
        ensure  => $qpage::config_ensure,
        backup  => false,
        path    => $qpage::_config_path,
        owner   => $qpage::_config_owner,
        group   => $qpage::_config_group,
        content => template('qpage/qpage.conf.erb'),
        mode    => $qpage::config_mode,
    }
}
