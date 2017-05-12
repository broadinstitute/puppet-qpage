# == Class: qpage
#
# This is the base qpage class that should orchestrate the installation of
# all the other pieces that make up the software.
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
class qpage (
    $administrator  = undef,
    $config_ensure  = 'present',
    $config_group   = undef,
    $config_mode    = undef,
    $config_owner   = undef,
    $config_path    = undef,
    $forcehostname  = undef,
    $identtimeout   = undef,
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
    $config_modems        = pick_default($modems, $qpage::params::modems)
    $config_pagers        = pick_default($pagers, $qpage::params::pagers)
    $config_pidfile       = pick_default($pidfile, $qpage::params::pidfile)
    $config_queuedir      = pick_default($queuedir, $qpage::params::queuedir)
    $config_service_defs  = pick_default($service_defs, $qpage::params::service_defs)
    $config_sigfile       = pick_default($sigfile, $qpage::params::sigfile)

    validate_bool($config_forcehostname)

    anchor { 'qpage::begin': } ->

    class { 'qpage::install': } ->
    class { 'qpage::config': } ->
    class { 'qpage::service': } ->

    anchor { 'qpage::end': }
}
