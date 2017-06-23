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

    it { should compile.with_all_deps }

    context 'with defaults for all parameters' do
        it { should contain_class('qpage') }
        it { should contain_service('qpage_service').with_enable(true) }
        it { should contain_service('qpage_service').with_ensure('running') }
        it { should contain_package('qpage_package').with_ensure('present') }
        it { should contain_file('qpage_config').with_ensure('present') }
    end

    context 'with package_ensure => absent' do
        let (:params) { { :package_ensure => 'absent' } }

        it { should contain_package('qpage_package').with_ensure('absent') }
    end

    context 'with service_enable => false' do
        let (:params) { { :service_enable => false } }

        it { should contain_service('qpage_service').with_enable(false) }
    end

    context 'with service_ensure => stopped' do
        let (:params) { { :service_ensure => 'stopped' } }

        it { should contain_service('qpage_service').with_ensure('stopped') }
    end

    context 'with custom service_name' do
        let (:params) { { :service_name => 'qpagetest' } }

        it { should contain_service('qpage_service').with_name('qpagetest') }
    end

end
