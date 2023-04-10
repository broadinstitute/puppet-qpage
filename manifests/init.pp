#
# @summary This is the base qpage class that should orchestrate the installation of all the other pieces that make up the software.
#
# @example Basic example to include the class
#   include qpage
#
# @example Include the class with options
#
#  class { 'qpage':
#    config_ensure  => 'absent',
#    package_ensure => 'absent',
#    service_ensure => 'stopped',
#  }
#
# Document parameters here.
#
# @param administrator
#   The e-mail address of the QuickPage administrator.
#
# @param config_ensure
#   Specifies the ensure parameter to the configuration file.
#
# @param config_group
#   The group of the configuration file.
#
# @param config_mode
#   The file mode for the configuration file.
#
# @param config_owner
#   The owner of the configuration file.
#
# @param config_path
#   The path to the configuration file.
#
# @param forcehostname
#   Force the destination address to be qualified with a hostname when
#   sending e-mail status notification to users.
#
# @param groups
#   A hash of hashes to define pager groups.  The keys of the top-level hashes
#   are the names of the groups.  The sub hashes should contain key/value
#   pairs with keys consisting of: text and members (which should be an array).
#
# @param identtimeout
#   The number of seconds to wait for a reply before giving  up  on RFC-1413
#   queries.
#
# @param include
#   Specifies the name of another configuration file that should be processed.
#
# @param lockdir
#   The location of the lock directory.
#
# @param modems
#   A hash of hashes to define modems.  The keys of the top-level hashes are
#   the names of the modem device.  The sub hashes should contain key/value
#   pairs with keys consisting of: text, device, initcmd, and dialcmd.
#
# @param package_ensure
#   Whether or not to install the package (Default: 'present')
#
# @param package_name
#   The name of the package to install (Default: 'qpage')
#
# @param package_provider
#   The provider used to install the package
#
# @param pagers
#   A hash of hashes to define pagers.  The keys of the top-level hashes are
#   the names of the pagers.  The sub hashes should contain key/value pairs
#   with keys consisting of: text, pagerid, and service.
#
# @param pidfile
#   Specifies a file into which the server should write its process ID.
#
# @param queuedir
#   The location of the page queue.
#
# @param service_defs
#   A hash of hashes to define services.  The keys of the top-level hashes are
#   the names of the services.  The sub hashes should contain key/value pairs
#   with keys consisting of: text, device, dialcmd, phone, password, baudrate,
#   parity, maxmsgsize, maxpages, maxtries, identfrom, allowpid, and msgprefix.
#
# @param service_enable
#   Whether or not to enable the service (Default: true)
#
# @param service_ensure
#   The ensure value for the service (Default: 'running')
#
# @param service_name
#   The name of the service (Default: 'qpage')
#
# @param sigfile
#   Specifies a file containing an alternate signature that QuickPage should
#   append to e-mail status notification messages sent to page submitters.
#
# @param snpptimeout
#   The number of seconds to wait for an SNPP command before terminating the
#   connection.
#
# @param synchronous
#   Whether or not queue runs are synchronized with new pages.
#
class qpage (
  String $administrator,
  Enum['absent', 'present'] $config_ensure,
  String $config_group,
  String $config_mode,
  String $config_owner,
  String $config_path,
  Enum['false', 'true'] $forcehostname,
  Optional[Hash] $groups,
  String $identtimeout,
  Optional[String] $include,
  Optional[String] $lockdir,
  Hash $modems,
  Enum['absent', 'held', 'installed', 'lastest', 'present', 'purged'] $package_ensure,
  String $package_name,
  String $package_provider,
  Hash $pagers,
  String $pidfile,
  String $queuedir,
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure,
  String $service_name,
  Hash $service_defs,
  String $sigfile,
  String $snpptimeout,
  String $synchronous,
) {
  contain qpage::install
  contain qpage::config
  contain qpage::service
}
