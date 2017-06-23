# == Class: qpage
#
# This is the base qpage class that should orchestrate the installation of
# all the other pieces that make up the software.
#
# === Parameters
#
# Document parameters here.
#
# [*administrator*]
#   The e-mail address of the QuickPage administrator.
#
# [*config_ensure*]
#   Specifies the ensure parameter to the configuration file.
#
# [*config_group*]
#   The group of the configuration file.
#
# [*config_mode*]
#   The file mode for the configuration file.
#
# [*config_owner*]
#   The owner of the configuration file.
#
# [*config_path*]
#   The path to the configuration file.
#
# [*forcehostname*]
#   Force the destination address to be qualified with a hostname when
#   sending e-mail status notification to users.
#
# [*identtimeout*]
#   The number of seconds to wait for a reply before giving  up  on RFC-1413
#   queries.
#
# [*include*]
#   Specifies the name of another configuration file that should be processed.
#
# [*lockdir*]
#   The location of the lock directory.
#
# [*modems*]
#   A hash of hashes to define modems.  The keys of the top-level hashes are
#   the names of the modem device.  The sub hashes should contain key/value
#   pairs with keys consisting of: text, device, initcmd, and dialcmd.
#
# [*package_ensure*]
#   Whether or not to install the package (Default: 'present')
#
# [*package_name*]
#   The name of the package to install (Default: 'qpage')
#
# [*pagers*]
#   A hash of hashes to define pagers.  The keys of the top-level hashes are
#   the names of the pagers.  The sub hashes should contain key/value pairs
#   with keys consisting of: text, pagerid, and service.
#
# [*pidfile*]
#   Specifies a file into which the server should write its process ID.
#
# [*queuedir*]
#   The location of the page queue.
#
# [*service_defs*]
#   A hash of hashes to define services.  The keys of the top-level hashes are
#   the names of the services.  The sub hashes should contain key/value pairs
#   with keys consisting of: text, device, dialcmd, phone, password, baudrate,
#   parity, maxmsgsize, maxpages, maxtries, identfrom, allowpid, and msgprefix.
#
# [*service_enable*]
#   Whether or not to enable the service (Default: true)
#
# [*service_ensure*]
#   The ensure value for the service (Default: 'running')
#
# [*service_name*]
#   The name of the service (Default: 'qpage')
#
# [*sigfile*]
#   Specifies a file containing an alternate signature that QuickPage should
#   append to e-mail status notification messages sent to page submitters.
#
# [*snpptimeout*]
#   The number of seconds to wait for an SNPP command before terminating the
#   connection.
#
# [*synchronous*]
#   Whether or not queue runs are synchronized with new pages.
#
# === Examples
#
# include ::qpage
#
# With options:
#
# class { 'qpage':
#    config_ensure  => 'absent',
#    package_ensure => 'absent',
#    service_ensure => 'stopped',
# }
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2017
#
class qpage (
    $administrator  = undef,
    $config_ensure  = 'present',
    $config_group   = undef,
    $config_mode    = undef,
    $config_owner   = undef,
    $config_path    = undef,
    $forcehostname  = undef,
    $identtimeout   = undef,
    $include        = undef,
    $lockdir        = undef,
    $modems         = undef,
    $package_ensure = 'present',
    $package_name   = undef,
    $pagers         = undef,
    $pidfile        = undef,
    $queuedir       = undef,
    $service_enable = true,
    $service_ensure = 'running',
    $service_name   = undef,
    $service_defs   = undef,
    $sigfile        = undef,
    $snpptimeout    = undef,
    $synchronous    = undef,
) {
    include ::qpage::params

    # Service Settings
    $_config_group    = pick($config_group, $qpage::params::config_group)
    $_config_mode     = pick($config_mode, $qpage::params::config_mode)
    $_config_owner    = pick($config_owner, $qpage::params::config_owner)
    $_config_path     = pick($config_path, $qpage::params::config_path)
    $_package_name    = pick($package_name, $qpage::params::package_name)
    $package_provider = $qpage::params::package_provider
    $_service_name    = pick($service_name, $qpage::params::service_name)

    validate_re($package_ensure, '^(absent|held|installed|latest|present|purged)$')
    validate_re($service_ensure, '^(running|stopped)$')

    # Config settings
    $config_administrator = pick_default($administrator, $qpage::params::administrator)
    $config_forcehostname = pick_default($forcehostname, $qpage::params::forcehostname)
    $config_identtimeout  = pick_default($identtimeout, $qpage::params::identtimeout)
    $config_include       = pick_default($include, $qpage::params::include)
    $config_lockdir       = pick_default($lockdir, $qpage::params::lockdir)
    $config_modems        = pick_default($modems, $qpage::params::modems)
    $config_pagers        = pick_default($pagers, $qpage::params::pagers)
    $config_pidfile       = pick_default($pidfile, $qpage::params::pidfile)
    $config_queuedir      = pick_default($queuedir, $qpage::params::queuedir)
    $config_service_defs  = pick_default($service_defs, $qpage::params::service_defs)
    $config_sigfile       = pick_default($sigfile, $qpage::params::sigfile)
    $config_snpptimeout   = pick_default($snpptimeout, $qpage::params::snpptimeout)
    $config_synchronous   = pick_default($synchronous, $qpage::params::synchronous)

    validate_bool($config_forcehostname)

    anchor { 'qpage::begin': } ->

    class { 'qpage::install': } ->
    class { 'qpage::config': } ->
    class { 'qpage::service': } ->

    anchor { 'qpage::end': }
}
