class profile::galera (

  $members  = ['192.168.99.101', '192.168.99.102'],
  $master   = 'control1.domain.name',

){

  class { 'galera':
    galera_servers => $members,
    galera_master  => $master,
  }

}
