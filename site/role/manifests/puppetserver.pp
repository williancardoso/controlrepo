class role::puppetserver {
  include profile::ntp
  include profile::puppet::server
  include profile::puppet::hiera
  include profile::puppet::r10k
}
