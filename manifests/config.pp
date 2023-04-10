#
# @summary This class takes care of all necessary configuration
#
class qpage::config {
  if ! defined(Class['qpage']) {
    fail('You must include the qpage base class before using any qpage defined resources')
  }

  $administrator = $qpage::administrator
  $forcehostname = $qpage::forcehostname
  $groups        = $qpage::groups
  $identtimeout  = $qpage::identtimeout
  $include       = $qpage::include
  $lockdir       = $qpage::lockdir
  $modems        = $qpage::modems
  $pagers        = $qpage::pagers
  $pidfile       = $qpage::pidfile
  $queuedir      = $qpage::queuedir
  $service_defs  = $qpage::service_defs
  $sigfile       = $qpage::sigfile
  $snpptimeout   = $qpage::snpptimeout
  $synchronous   = $qpage::synchronous

  file { 'qpage_config':
    ensure  => $qpage::config_ensure,
    backup  => false,
    content => template('qpage/qpage.conf.erb'),
    group   => $qpage::config_group,
    mode    => $qpage::config_mode,
    owner   => $qpage::config_owner,
    path    => $qpage::config_path,
  }
}
