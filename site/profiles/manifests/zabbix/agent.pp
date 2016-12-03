class profile::zabbix::agent (

  $server  = undef,

) {

  class { 'zabbix::agent':
    server => $server,
  }

}
