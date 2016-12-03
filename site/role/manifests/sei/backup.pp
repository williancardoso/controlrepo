class role::sei::backup {

  include profile::sei::xtrabackup
  include profile::nfs::client
  include profile::zabbix::agent

}
