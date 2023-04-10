#
# @summary This class takes care of all necessary package installations
#
class qpage::install {
  if ! defined(Class['qpage']) {
    fail('You must include the qpage base class before using any qpage defined resources')
  }

  if $facts['os']['family'] == 'FreeBSD' {
    require pkgng
  }

  package { 'qpage_package':
    ensure   => $qpage::package_ensure,
    name     => $qpage::package_name,
    provider => $qpage::package_provider,
  }
}
