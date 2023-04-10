require 'spec_helper'

describe 'qpage' do
  let(:facts) do
    {
      kernel: 'FreeBSD',
      kernelrelease: '10.3-RELEASE',
      os: {
        family: 'FreeBSD',
        name: 'FreeBSD',
        release: {
          full: '10.3-RELEASE',
          major: '10',
        },
      },
    }
  end

  it do
    is_expected.to compile.with_all_deps
  end

  context 'with defaults for all parameters' do
    it do
      is_expected.to contain_class('pkgng')
    end
    it do
      is_expected.to contain_class('qpage')
    end
    it do
      is_expected.to contain_class('qpage::install')
    end
    it do
      is_expected.to contain_class('qpage::config')
    end
    it do
      is_expected.to contain_class('qpage::service')
    end
    it do
      is_expected.to contain_service('qpage_service').with(
        enable: true,
        ensure: 'running',
        name: 'qpage',
      )
    end
    it do
      is_expected.to contain_package('qpage_package').with(
        ensure: 'present',
        name: 'qpage',
        provider: 'pkgng',
      )
    end
    it do
      is_expected.to contain_file('qpage_config').with(
        ensure: 'present',
        group: 'wheel',
        mode: '0644',
        owner: 'root',
        path: '/usr/local/etc/qpage.conf',
      )
    end
  end

  context 'with package_ensure => absent' do
    let(:params) do
      { package_ensure: 'absent' }
    end

    it do
      is_expected.to contain_package('qpage_package').with_ensure('absent')
    end
  end

  context 'with custom package_name' do
    let(:params) do
      { package_name: 'notqpage' }
    end

    it do
      is_expected.to contain_package('qpage_package').with(name: 'notqpage')
    end
  end

  context 'with service_enable => false' do
    let(:params) do
      { service_enable: false }
    end

    it do
      is_expected.to contain_service('qpage_service').with_enable(false)
    end
  end

  context 'with service_ensure => stopped' do
    let(:params) do
      { service_ensure: 'stopped' }
    end

    it do
      is_expected.to contain_service('qpage_service').with_ensure('stopped')
    end
  end

  context 'with config_ensure => absent' do
    let(:params) do
      { config_ensure: 'absent' }
    end

    it do
      is_expected.to contain_file('qpage_config').with_ensure('absent')
    end
  end

  context 'with custom service_name' do
    let(:params) do
      { service_name: 'qpagetest' }
    end

    it do
      is_expected.to contain_service('qpage_service').with_name('qpagetest')
    end
  end

  # Custom configuration parameters
  context 'configuration parameters' do
    context 'with custom administrator' do
      let(:params) do
        { administrator: 'testadmin@example.com' }
      end

      it do
        is_expected.to contain_file('qpage_config').with(content: %r{administrator=testadmin@example.com})
      end
    end

    context 'with custom forcehostname' do
      let(:params) do
        { forcehostname: 'true' }
      end

      it do
        is_expected.to contain_file('qpage_config').with(content: %r{forcehostname=true})
      end
    end

    context 'with custom groups' do
      let(:params) do
        {
          groups: {
            testgroup: {
              text: 'TestGroup',
              members: [
                'pager1',
                'pager2',
              ],
            },
          },
        }
      end

      it do
        is_expected.to contain_file('qpage_config').with(
          content: %r{group=testgroup\n\s+text=TestGroup\n\s+member=pager1\n\s+member=pager2},
        )
      end
    end

    context 'with custom identtimeout' do
      let(:params) do
        { identtimeout: '20' }
      end

      it do
        is_expected.to contain_file('qpage_config').with(content: %r{identtimeout=20})
      end
    end

    context 'with custom include' do
      let(:params) do
        { include: '/usr/local/etc/qpage.d/custom.conf' }
      end

      it do
        is_expected.to contain_file('qpage_config').with(
          content: %r{include=\/usr\/local\/etc\/qpage.d\/custom.conf},
        )
      end
    end

    context 'with custom lockdir' do
      let(:params) do
        { lockdir: '/var/lock/qpage' }
      end

      it do
        is_expected.to contain_file('qpage_config').with(content: %r{lockdir=\/var\/lock\/qpage})
      end
    end
    context 'with custom modems' do
      let(:params) do
        {
          modems: {
            modem0: {
              device: '/dev/testmodem',
              initcmd: 'ATZXXXXX',
              dialcmd: 'thecommand',
            },
          },
        }
      end

      it do
        is_expected.to contain_file('qpage_config').with(
          content: %r{modem=modem0\n\s+device=\/dev\/testmodem\n\s+dialcmd=thecommand\n\s+initcmd=ATZXXXXX},
        )
      end
    end

    context 'with custom pagers' do
      let(:params) do
        {
          pagers: {
            testpager: {
              text: 'TestPager',
              pagerid: '15555559999',
              service: 'servicename',
            },
          },
        }
      end

      it do
        is_expected.to contain_file('qpage_config').with(
          content: %r{pager=testpager\n\s+pagerid=15555559999\n\s+service=servicename\n\s+text=TestPager},
        )
      end
    end

    context 'with custom pidfile' do
      let(:params) do
        { pidfile: '/tmp/qpage.pid' }
      end

      it do
        is_expected.to contain_file('qpage_config').with(content: %r{pidfile=\/tmp\/qpage.pid})
      end
    end

    context 'with custom queuedir' do
      let(:params) do
        { queuedir: '/tmp/qpageq' }
      end

      it do
        is_expected.to contain_file('qpage_config').with(content: %r{queuedir=\/tmp\/qpageq})
      end
    end

    context 'with custom service_defs' do
      let(:params) do
        {
          service_defs: {
            testservice: {
              text: 'TestService',
              device: 'modem99',
              dialcmd: 'dialit',
              phone: 'thephone',
              password: 'pass123',
              baudrate: '999',
              parity: '22',
              maxmsgsize: '100',
              maxpages: '55',
              maxtries: '77',
              identfrom: 'false',
              allowpid: 'true',
              msgprefix: 'theprefix',
            },
          },
        }
      end

      it do
        is_expected.to contain_file('qpage_config').with(
          # rubocop:disable Metrics/LineLength
          content: %r{service=testservice\n\s+allowpid=true\n\s+baudrate=999\n\s+device=modem99\n\s+dialcmd=dialit\n\s+identfrom=false\n\s+maxmsgsize=100\n\s+maxpages=55\n\s+maxtries=77\n\s+msgprefix=theprefix\n\s+parity=22\n\s+password=pass123\n\s+phone=thephone\n\s+text=TestService},
          # rubocop:enable Metrics/LineLength
        )
      end
    end

    context 'with custom sigfile' do
      let(:params) do
        { sigfile: '/tmp/qpage.sig' }
      end

      it do
        is_expected.to contain_file('qpage_config').with(content: %r{sigfile=\/tmp\/qpage.sig})
      end
    end

    context 'with custom snpptimeout' do
      let(:params) do
        { snpptimeout: '200' }
      end

      it do
        is_expected.to contain_file('qpage_config').with(content: %r{snpptimeout=200})
      end
    end

    context 'with custom synchronous' do
      let(:params) do
        { synchronous: 'false' }
      end

      it do
        is_expected.to contain_file('qpage_config').with(content: %r{synchronous=false})
      end
    end
  end
end
