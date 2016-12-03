class profile::zabbix::server (

  $url  = undef,

) {

  class { 'apache':
    mpm_module => 'prefork',
  }

  include apache::mod::php

  class { 'postgresql::server': }

  class { 'zabbix':
    zabbix_url    => $url,
  }

}
