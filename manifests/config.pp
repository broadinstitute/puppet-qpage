# == Class: qpage::config
#
# This class takes care of all necessary configuration
#
# === Variables
#
# [*qpage::config_administrator*]
#   The e-mail address of the QuickPage administrator.
#
# [*qpage::config_forcehostname*]
#   Force the destination address to be qualified with a hostname when
#   sending e-mail status notification to users.
#
# [*qpage::config_identtimeout*]
#   The number of seconds to wait for a reply before giving  up  on RFC-1413
#   queries.
#
# [*qpage::config_include*]
#   Specifies the name of another configuration file that should be processed.
#
# [*qpage::config_lockdir*]
#   The location of the lock directory.
#
# [*qpage::config_modems*]
#   A hash of hashes to define modems.  The keys of the top-level hashes are
#   the names of the modem device.  The sub hashes should contain key/value
#   pairs with keys consisting of: text, device, initcmd, and dialcmd.
#
# [*qpage::config_pagers*]
#   A hash of hashes to define pagers.  The keys of the top-level hashes are
#   the names of the pagers.  The sub hashes should contain key/value pairs
#   with keys consisting of: text, pagerid, and service.
#
# [*qpage::config_pidfile*]
#   Specifies a file into which the server should write its process ID.
#
# [*qpage::config_queuedir*]
#   The location of the page queue.
#
# [*qpage::config_service_defs*]
#   A hash of hashes to define services.  The keys of the top-level hashes are
#   the names of the services.  The sub hashes should contain key/value pairs
#   with keys consisting of: text, device, dialcmd, phone, password, baudrate,
#   parity, maxmsgsize, maxpages, maxtries, identfrom, allowpid, and msgprefix.
#
# [*qpage::config_sigfile*]
#   Specifies a file containing an alternate signature that QuickPage should
#   append to e-mail status notification messages sent to page submitters.
#
# [*qpage::config_snpptimeout*]
#   The number of seconds to wait for an SNPP command before terminating the
#   connection.
#
# [*qpage::config_synchronous*]
#   Whether or not queue runs are synchronized with new pages.
#
# [*qpage::config_ensure*]
#   Specifies the ensure parameter to the configuration file.
#
# [*qpage::_config_path*]
#   The path to the configuration file.
#
# [*qpage::_config_owner*]
#   The owner of the configuration file.
#
# [*qpage::_config_group*]
#   The group of the configuration file.
#
# [*qpage::config_mode*]
#   The file mode for the configuration file.
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

    $administrator = $::qpage::config_administrator
    $forcehostname = $::qpage::config_forcehostname
    $identtimeout  = $::qpage::config_identtimeout
    $include       = $::qpage::config_include
    $lockdir       = $::qpage::config_lockdir
    $modems        = $::qpage::config_modems
    $pagers        = $::qpage::config_pagers
    $pidfile       = $::qpage::config_pidfile
    $queuedir      = $::qpage::config_queuedir
    $service_defs  = $::qpage::config_service_defs
    $sigfile       = $::qpage::config_sigfile
    $snpptimeout   = $::qpage::config_snpptimeout
    $synchronous   = $::qpage::config_synchronous

    file { 'qpage_config':
        ensure  => $::qpage::config_ensure,
        backup  => false,
        path    => $::qpage::_config_path,
        owner   => $::qpage::_config_owner,
        group   => $::qpage::_config_group,
        content => template('qpage/qpage.conf.erb'),
        mode    => $::qpage::config_mode,
    }
}
