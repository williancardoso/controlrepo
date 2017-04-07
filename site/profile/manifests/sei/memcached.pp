class profile::sei::memcached {

  package { 'memcached':
    ensure => present
  }

  service { 'memcached':
    ensure => running,
    enable => true,
  }

}
