class profile::sei::jod (

) {

  require profile::sei::jdk

  group { 'tomcat':
    ensure => 'present',
  }

  user { 'tomcat':
    ensure  => 'present',
    home    => '/opt/jodconverter/tomcat',
    shell   => '/bin/bash',
    require => Group['tomcat'],
  }

  file { '/opt/jodconverter':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'tomcat',
    group   => 'tomcat',
    require => User['tomcat'],
  }

  file { '/opt/jodconverter/tomcat.tar':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'tomcat',
    group   => 'tomcat',
    source  => 'puppet:///modules/seiaio/jod/tomcat.tar',
    require => File['/opt/jodconverter'],
  }

  exec { 'extrai_jod':
    command => 'tar xf tomcat.tar;chown -R tomcat.tomcat /opt/jodconverter',
    cwd     => '/opt/jodconverter',
    creates => '/opt/jodconverter/tomcat',
    path    => ['/bin', '/usr/bin', '/usr/sbin', '/usr/local/bin'],
    require  => File['/opt/jodconverter/tomcat.tar'],
  }

  package { 'libreoffice':
    ensure  => present,
    name    => 'libreoffice-headless',
  }

  file {'soffice':
    ensure  => 'file',
    name    => '/etc/init.d/soffice',
    mode    => '0755',
    source  => 'puppet:///modules/seiaio/jod/initd/soffice',
    require => Package['libreoffice'],
  }

  file {'jodconverter':
    ensure  => 'file',
    name    => '/etc/init.d/jodconverter',
    mode    => '0755',
    source  => 'puppet:///modules/seiaio/jod/initd/jodconverter',
    require => Package['libreoffice'],
  }

  service { 'jodconverter':
    ensure  => 'running',
    enable  =>  true,
    status  => 'ps -ef | grep tomcat | grep -qv grep',
    require => File['jodconverter'],
  }

  service { 'soffice':
    ensure  => 'running',
    enable  =>  true,
    status  => 'ps -ef | grep soffice | grep -qv grep',
    require => File['soffice'],
  }

}
