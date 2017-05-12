#!/usr/bin/env sh

CONFDIR='/usr/local/etc'

pkg update
pkg install -y git puppet4 vim
mv /tmp/Gemfile $CONFDIR/puppetlabs/code/
mv /tmp/hiera.yaml $CONFDIR/puppetlabs/code/
mkdir -p $CONFDIR/puppetlabs/code/hieradata
mkdir -p $CONFDIR/puppetlabs/code/modules
touch $CONFDIR/puppetlabs/code/hieradata/global.yaml
gem install bundle rake --no-rdoc --no-ri
/usr/local/bin/bundle config --global silence_root_warning 1
cd $CONFDIR/puppetlabs/code
/usr/local/bin/bundle install
cd $CONFDIR/puppetlabs/code/modules/qpage
rm -f Puppetfile.lock
/usr/local/bin/librarian-puppet install --verbose --path=$CONFDIR/puppetlabs/code/modules
