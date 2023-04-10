#
# @summary This class takes care of all necessary services
#
class qpage::service {
  if ! defined(Class['qpage']) {
    fail('You must include the qpage base class before using any qpage defined resources')
  }

  service { 'qpage_service':
    ensure    => $qpage::service_ensure,
    enable    => $qpage::service_enable,
    name      => $qpage::service_name,
    subscribe => [
      File['qpage_config'],
      Package['qpage_package'],
    ],
  }
}
