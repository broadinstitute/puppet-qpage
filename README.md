# puppet-qpage

![checks](https://github.com/broadinstitute/puppet-qpage/workflows/checks/badge.svg?branch=main)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/broadinstitute/qpage.svg)](https://forge.puppet.com/broadinstitute/qpage)
[![Puppet Forge](https://img.shields.io/puppetforge/v/broadinstitute/qpage.svg)](https://forge.puppet.com/broadinstitute/qpage)
[![Puppet Forge](https://img.shields.io/puppetforge/f/broadinstitute/qpage.svg)](https://forge.puppet.com/broadinstitute/qpage)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![codecov](https://codecov.io/gh/broadinstitute/puppet-qpage/branch/main/graph/badge.svg)](https://codecov.io/gh/broadinstitute/puppet-qpage)

## Table of Contents

* [Overview](#overview)
* [Module Description - Puppet module to control all aspects of the QPage service](#module-description)
* [Setup - The basics of getting started with qpage](#setup)
  * [What qpage affects](#what-qpage-affects)
  * [Setup requirements](#setup-requirements)
* [Usage - Configuration options and additional functionality](#usage)
* [Reference - An under-the-hood peek at what the module is doing and how](#reference)
* [Limitations - OS compatibility, etc.](#limitations)
* [Development - Guide for contributing to the module](#development)

## Overview

This module is designed to take care of installing and configuring the QPage service. QPage is an SNPP client/server for sending messages to an alpha-numeric pager.

## Module Description

This module should correctly setup QPage on a given host.  This includes:

* Package installation
* Service management
* Configuration management

## Setup

### What qpage affects

* packages:
  * qpage
* services:
  * qpage
* files:
  * /usr/local/etc/qpage.conf

### Setup Requirements **OPTIONAL**

librarian-puppet install --verbose --path=/etc/puppetlabs/code/modules

Note: this module requires the **zleslie/pkgng** module for controlling packages on FreeBSD.

## Usage

To get a default qpage installation, you can simply include the class with all the defaults:

```puppet
include ::qpage
```

The module allows you to remove the service completely if desired as well:

```puppet
class { 'qpage':
    config_ensure  => 'absent',
    package_ensure => 'absent',
    service_ensure => 'stopped',
}
```

All the configuration options in the file are also configurable via options in the main `qpage` class:

```puppet
class { 'qpage':
    administrator => 'admin@example.com',
    forcehostname => false,
    identtimeout  => 0,
    modems        => {
        modem0 => {
            device  => '/dev/modem',
            initcmd => 'ATZXXXXX',
        }
    },
    pagers        => {
        pager1 => {
            text    => 'UserName',
            pagerid => '5555551234',
            service => 'servicename',
        }
    },
    pidfile       => '/var/run/qpage',
    queuedir      => '/var/spool/qpage',
    service_defs  => {
        servicename => {
            text       => 'ServiceName',
            device     => 'modem0',
            phone      => '9,15555559876',
            identfrom  => 'false',
            maxmsgsize => '160',
            baudrate   => '9600',
            parity     => 'even',
        }
    },
    sigfile       => '/dev/null',
}
```

You can also do the same using Hiera:

```yaml
---
qpage::administrator: 'admin@example.com'
qpage::forcehostname: false
qpage::identtimeout: 0
qpage::modems:
    modem0:
        device: '/dev/modem'
        initcmd: 'ATZXXXXX'
qpage::pagers:
    pager1:
        text: 'UserName'
        pagerid: '5555551234'
        service: 'servicename'
qpage::pidfile: '/var/run/qpage'
qpage::queuedir: '/var/spool/qpage'
qpage::service_defs:
    servicename:
        text: 'ServiceName'
        device: 'modem0'
        phone: '9,15555559876'
        identfrom: 'false'
        maxmsgsize: '160'
        baudrate: '9600'
        parity: 'even'
qpage::sigfile: '/dev/null'
```

## Reference

All the work for this module typicallly happens through the `qpage` class.  No calls to the subclasses should be necessary as they are all controlled via the main `init.pp` file.

## Limitations

This module is currently only supported on FreeBSD systems, since that is the only place I could find this package when writing this module.  If you have any enhancements for different operating systems, bug fixes, etc., pull requests are always welcome.

## Development

Refer to CONTRIBUTING.md
