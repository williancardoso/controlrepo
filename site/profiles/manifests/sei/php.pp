class profile::sei::php (

  $docroot = $::seiaio::params::httpd_sei_docroot,

) {

  package { 'php': ensure => present }

  package { 'php-cli':      ensure => present }
  package { 'php-pear':     ensure => present }
  package { 'php-bcmath':   ensure => present }
  package { 'php-gd':       ensure => present }
  package { 'php-imap':     ensure => present }
  package { 'php-ldap':     ensure => present }
  package { 'php-mbstring': ensure => present }
  package { 'php-mysql':    ensure => present }
  package { 'php-pdo':      ensure => present }
  package { 'php-soap':     ensure => present }
  package { 'php-xml':      ensure => present }
  package { 'php-intl':     ensure => present,}
  package { 'php-odbc':     ensure => present, }
  package { 'php-snmp':     ensure => present, }
  package { 'php-xmlrpc':   ensure => present, }
  package { 'php-pspell':   ensure => present, }
  package { 'php-pecl-apc': ensure => present, }
  package { 'php-pecl-apc-devel': ensure => present, }
  package { 'php-pecl-memcache':  ensure => present, }
  package { 'php-zts':            ensure => present, }
  package { 'gcc': ensure => present, }

  exec { '/usr/bin/pecl install uploadprogress':
    creates => '/usr/lib64/php/modules/uploadprogress.so',
  }

  file { '/etc/php.d/uploadprogress.ini':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => 'extension=uploadprogress.so',
    notify  => Exec['apachectl_restart']
  }

  exec { 'apachectl_restart':
    command     => '/usr/sbin/apachectl -k restart',
    refreshonly => true,
  }

  ini_setting { "post_max_size":
    ensure  => present,
    path    => '/etc/php.ini',
    section => 'PHP',
    setting => 'post_max_size',
    value   => '100',
    notify  => Exec['apachectl_restart']
  }

  ini_setting { "default_charset":
    ensure  => present,
    path    => '/etc/php.ini',
    section => 'PHP',
    setting => 'default_charset',
    value   => 'iso-8859-1',
    notify  => Exec['apachectl_restart']
  }

  ini_setting { "short_open_tag":
    ensure  => present,
    path    => '/etc/php.ini',
    section => 'PHP',
    setting => 'short_open_tag',
    value   => 'On',
    notify  => Exec['apachectl_restart']
  }

  ini_setting { "default_socket_timeout":
    ensure  => present,
    path    => '/etc/php.ini',
    section => 'PHP',
    setting => 'default_socket_timeout',
    value   => '60',
    notify  => Exec['apachectl_restart']
  }

  ini_setting { "include_path":
    ensure  => present,
    path    => '/etc/php.ini',
    section => 'PHP',
    setting => 'include_path',
    value   => ".:/${docroot}/infra_php",
    notify  => Exec['apachectl_restart']
  }

  ini_setting { "session_gc_maxlifetime":
    ensure  => present,
    path    => '/etc/php.ini',
    section => 'Session',
    setting => 'session.gc_maxlifetime',
    value   => '4600',
    notify  => Exec['apachectl_restart']
  }

  ini_setting { "date_timezone":
    ensure  => present,
    path    => '/etc/php.ini',
    section => 'Session',
    setting => 'session.gc_maxlifetime',
    value   => '4600',
    notify  => Exec['apachectl_restart']
  }
}
