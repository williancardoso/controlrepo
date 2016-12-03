class role::sei::nfs {

  include profile::nfs::server
  include profile::zabbix::agent

}
