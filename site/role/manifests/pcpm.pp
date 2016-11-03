class role::pcpm {
  include profile::ntp
  include profile::puppet::server
  include profile::puppet::hiera
  include profile::puppet::r10k
  include profile::puppetdb::database
  include profile::puppetdb::app
  include profile::puppetdb::frontend
  include profile::activemq
  include profile::mcollective::server
  include profile::mcollective::client
}
