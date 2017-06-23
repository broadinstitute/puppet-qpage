require 'spec_helper'

describe 'qpage' do

    let(:facts) { {
        :kernel => 'FreeBSD',
        :kernelrelease => '10.3-RELEASE',
        :operatingsystem => 'FreeBSD',
        :operatingsystemmajrelease => '10',
        :operatingsystemrelease => '10.3-RELEASE',
        :osfamily => 'FreeBSD',
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

    # let(:params) {{
    #     :administrator => :undef,
    #     :forcehostname => :undef,
    #     :identtimeout => :undef,
    #     :include => :undef,
    #     :lockdir => :undef,
    #     :modems => :undef,
    #     :package_name => :undef,
    #     :pagers => :undef,
    #     :pidfile => :undef,
    #     :queuedir => :undef,
    #     :service_enable => true,
    #     :service_name => :undef,
    #     :service_defs => :undef,
    #     :sigfile => :undef,
    #     :snpptimeout => :undef,
    #     :synchronous => :undef,
    # }}

end
