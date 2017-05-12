require 'spec_helper'

describe 'qpage' do

    on_supported_os.each do |os, facts|
        context "on #{os}" do
            let(:facts) do
                facts
        end

        it { should compile.with_all_deps }

        context 'with defaults for all parameters' do
            it { should contain_class('qpage') }
            # it { should contain_group('qpage').with_ensure('present') }
            # it { should contain_user('qpage').with_ensure('present') }
            # it { should contain_service('qpage_service').with_enable(true) }
            # it { should contain_service('qpage_service').with_ensure('running') }
            # it { should contain_package('qpage').with_ensure('present') }
        end

        context 'with manage_group => false' do
            let (:params) { { :manage_group => false } }

            it { should_not contain_group('qpage') }
        end

        context 'with manage_user => false' do
            let (:params) { { :manage_user => false } }

            it { should_not contain_user('qpage') }
        end

        context 'with custom group' do
            let (:params) { { :daemon_group => 'testgrp' } }

            it { should contain_group('testgrp').with_ensure('present') }
        end

        context 'with custom user' do
            let (:params) { { :daemon_user => 'testuser' } }

            it { should contain_user('testuser').with_ensure('present') }
        end

        context 'with package_ensure => absent' do
            let (:params) { { :package_ensure => 'absent' } }

            it { should contain_package('qpage').with_ensure('absent') }
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

        case facts[:osfamily]
            when 'Debian'

                context 'osfamily differences with defaults for all parameters' do
                    it { should contain_class('apt') }
                    it { should_not contain_class('epel') }
                    it { should contain_concat('/etc/qpage/conf.d/60-puppet') }
                    it { should contain_service('qpage_service').with_name('qpage') }
                end

                context 'with a custom config_dir' do
                    let (:params) { { :config_dir => '/etc/testing' } }

                    it { should contain_concat('/etc/testing/60-puppet') }
                end

                context 'with a custom config_file' do
                    let (:params) { { :config_file => 'test.conf' } }

                    it { should contain_concat('/etc/qpage/conf.d/test.conf') }
                end
            end
        end
    end
end
