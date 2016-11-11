class role::broker {
  include profile::ntp
  include profile::puppet::agent
  include profile::activemq
  include profile::mcollective::server
  include profile::mcollective::client
}
