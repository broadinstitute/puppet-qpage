require 'spec_helper'

describe 'qpage' do

    let(:facts) { {
        :kernel                    => 'FreeBSD',
        :kernelrelease             => '10.3-RELEASE',
        :operatingsystem           => 'FreeBSD',
        :operatingsystemmajrelease => '10',
        :operatingsystemrelease    => '10.3-RELEASE',
        :osfamily                  => 'FreeBSD',
    }}

    it { is_expected.to compile.with_all_deps }

    context 'with defaults for all parameters' do
        it { is_expected.to contain_class('pkgng') }
        it { is_expected.to contain_class('qpage') }
        it { is_expected.to contain_class("qpage::install") }
        it { is_expected.to contain_class("qpage::config") }
        it { is_expected.to contain_class("qpage::service") }
        it { is_expected.to contain_service('qpage_service').with({
            'enable' => true,
            'ensure' => 'running',
            'name'   => 'qpage',
            })
        }
        it { is_expected.to contain_package('qpage_package').with({
            'ensure'   => 'present',
            'name'     => 'qpage',
            'provider' => 'pkgng',
            })
        }
        it { is_expected.to contain_file('qpage_config').with({
            'ensure' => 'present',
            'group'  => 'wheel',
            'mode'   => '0644',
            'owner'  => 'root',
            'path'   => '/usr/local/etc/qpage.conf',
            })
        }
    end

    context 'with package_ensure => absent' do
        let (:params) { { :package_ensure => 'absent' } }

        it { is_expected.to contain_package('qpage_package').with_ensure('absent') }
    end

    context 'with custom package_name' do
        let (:params) { { :package_name => 'notqpage' } }

        it { is_expected.to contain_package('qpage_package').with({
            'name' => 'notqpage'
            })
        }
    end

    context 'with service_enable => false' do
        let (:params) { { :service_enable => false } }

        it { is_expected.to contain_service('qpage_service').with_enable(false) }
    end

    context 'with service_ensure => stopped' do
        let (:params) { { :service_ensure => 'stopped' } }

        it { is_expected.to contain_service('qpage_service').with_ensure('stopped') }
    end

    context 'with config_ensure => absent' do
        let (:params) { { :config_ensure => 'absent' } }

        it { is_expected.to contain_file('qpage_config').with_ensure('absent') }
    end

    context 'with custom service_name' do
        let (:params) { { :service_name => 'qpagetest' } }

        it { is_expected.to contain_service('qpage_service').with_name('qpagetest') }
    end

    # Custom configuration parameters
    context 'configuration parameters' do
        context 'with custom administrator' do
            let (:params) { { :administrator => 'testadmin@example.com' } }

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /administrator=testadmin@example.com/
                })
            }
        end
        context 'with custom forcehostname' do
            let (:params) { { :forcehostname => 'true' } }

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /forcehostname=true/
                })
            }
        end
        context 'with custom groups' do
            let (:params) {{
                :groups => {
                    'testgroup' => {
                        'text'    => 'TestGroup',
                        'members' => [
                            'pager1',
                            'pager2',
                        ]
                    }
                }
            }}

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /group=testgroup\n\s+text=TestGroup\n\s+member=pager1\n\s+member=pager2/
                })
            }
        end
        context 'with custom identtimeout' do
            let (:params) { { :identtimeout => '20' } }

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /identtimeout=20/
                })
            }
        end
        context 'with custom include' do
            let (:params) { { :include => '/usr/local/etc/qpage.d/custom.conf' } }

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /include=\/usr\/local\/etc\/qpage.d\/custom.conf/
                })
            }
        end
        context 'with custom lockdir' do
            let (:params) { { :lockdir => '/var/lock/qpage' } }

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /lockdir=\/var\/lock\/qpage/
                })
            }
        end
        context 'with custom modems' do
            let (:params) {{
                :modems => {
                    'modem0' => {
                        'device'  => '/dev/testmodem',
                        'initcmd' => 'ATZXXXXX',
                        'dialcmd' => 'thecommand',
                    }
                }
            }}

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /modem=modem0\n\s+device=\/dev\/testmodem\n\s+dialcmd=thecommand\n\s+initcmd=ATZXXXXX/
                })
            }
        end
        context 'with custom pagers' do
            let (:params) {{
                :pagers => {
                    'testpager' => {
                        'text'    => 'TestPager',
                        'pagerid' => '15555559999',
                        'service' => 'servicename',
                    }
                }
            }}

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /pager=testpager\n\s+pagerid=15555559999\n\s+service=servicename\n\s+text=TestPager/
                })
            }
        end
        context 'with custom pidfile' do
            let (:params) { { :pidfile => '/tmp/qpage.pid' } }

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /pidfile=\/tmp\/qpage.pid/
                })
            }
        end
        context 'with custom queuedir' do
            let (:params) { { :queuedir => '/tmp/qpageq' } }

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /queuedir=\/tmp\/qpageq/
                })
            }
        end
        context 'with custom service_defs' do
            let (:params) {{
                :service_defs => {
                    'testservice' => {
                        'text' => 'TestService',
                        'device' => 'modem99',
                        'dialcmd' => 'dialit',
                        'phone' => 'thephone',
                        'password' => 'pass123',
                        'baudrate' => '999',
                        'parity' => '22',
                        'maxmsgsize' => '100',
                        'maxpages' => '55',
                        'maxtries' => '77',
                        'identfrom' => 'false',
                        'allowpid' => 'true',
                        'msgprefix' => 'theprefix'
                    }
                }
            }}

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /service=testservice\n\s+allowpid=true\n\s+baudrate=999\n\s+device=modem99\n\s+dialcmd=dialit\n\s+identfrom=false\n\s+maxmsgsize=100\n\s+maxpages=55\n\s+maxtries=77\n\s+msgprefix=theprefix\n\s+parity=22\n\s+password=pass123\n\s+phone=thephone\n\s+text=TestService/
                })
            }
        end
        context 'with custom sigfile' do
            let (:params) { { :sigfile => '/tmp/qpage.sig' } }

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /sigfile=\/tmp\/qpage.sig/
                })
            }
        end
        context 'with custom snpptimeout' do
            let (:params) { { :snpptimeout => '200' } }

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /snpptimeout=200/
                })
            }
        end
        context 'with custom synchronous' do
            let (:params) { { :synchronous => 'false' } }

            it { is_expected.to contain_file('qpage_config').with({
                'content' => /synchronous=false/
                })
            }
        end
    end
end
