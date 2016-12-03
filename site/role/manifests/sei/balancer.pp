class role::sei::balancer {

  include profile::sei::nginx
  include profile::nfs::client
  include profile::zabbix::agent
}
