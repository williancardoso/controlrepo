class role::sei::banco {

  include profile::percona::server
  include profile::nfs::client
  include profile::zabbix::agent
}
