class role::sei::zabbix {

  include profile::zabbix::server
  include profile::nfs::client
  
}
