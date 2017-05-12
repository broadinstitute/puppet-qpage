# == Class: qpage::service
#
# This class takes care of all necessary services
#
# === Authors
#
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2017
#
class qpage::service {

    service { 'qpage_service':
        ensure => $qpage::service_ensure,
        enable => $qpage::service_enable,
        name   => $qpage::_service_name,
    }
}
