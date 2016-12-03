class profile::percona::server (

){

  yumrepo { 'percona':
    descr    => 'CentOS $releasever - Percona',
    baseurl  => 'http://repo.percona.com/centos/$releasever/os/$basearch/',
    gpgkey   => 'http://www.percona.com/downloads/percona-release/RPM-GPG-KEY-percona',
    enabled  => 1,
    gpgcheck => 1,
  }

  class {'mysql::server':
    package_name     => 'Percona-Server-server-57',
    package_ensure   => '5.7.11-4.1.el7',
    service_name     => 'mysql',
    config_file      => '/etc/my.cnf',
    includedir       => '/etc/my.cnf.d',
    root_password    => 'PutYourOwnPwdHere',
    override_options => {
      mysqld => {
        log-error => '/var/log/mysqld.log',
        pid-file  => '/var/run/mysqld/mysqld.pid',
      },
      mysqld_safe => {
        log-error => '/var/log/mysqld.log',
      },
    }
  }

  # Note: Installing Percona-Server-server-57 also installs Percona-Server-client-57.
  # This shows how to install the Percona MySQL client on its own
  class {'mysql::client':
    package_name   => 'Percona-Server-client-57',
    package_ensure => '5.7.11-4.1.el7',
  }

  # These packages are normally installed along with Percona-Server-server-57
  # If you needed to install the bindings, however, you could do so with this code
  class { 'mysql::bindings':
    client_dev_package_name   => 'Percona-Server-shared-57',
    client_dev_package_ensure => '5.7.11-4.1.el7',
    client_dev                => true,
    daemon_dev_package_name   => 'Percona-Server-devel-57',
    daemon_dev_package_ensure => '5.7.11-4.1.el7',
    daemon_dev                => true,
    perl_enable               => true,
    perl_package_name         => 'perl-DBD-MySQL',
    python_enable             => true,
    python_package_name       => 'MySQL-python',
  }

  # Dependencies definition
  Yumrepo['percona'] -> Class['mysql::server']
  Yumrepo['percona'] -> Class['mysql::client']
  Yumrepo['percona'] -> Class['mysql::bindings']

}
