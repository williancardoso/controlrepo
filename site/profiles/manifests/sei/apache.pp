class profile::sei::apache (

  String $docroot     = '/var/www/html',
  String $git_repo    = undef,
  String $dominio     = undef,
  String $owner       = undef,
  String $group       = undef,
  String $docroot     = undef,
  String $seidados    = undef,

){

  class { '::apache':
    mpm_module => false,
  }

  class { '::apache::mod::prefork':
    startservers        => '12',
    minspareservers     => '6',
    maxspareservers     => '64',
    serverlimit         => '1024',
    maxclients          => '1024',
    maxrequestsperchild => '2000'
  }

  include ::apache::mod::php
  include ::apache::mod::rewrite
  include ::apache::mod::ssl

  apache::vhost { $dominio:
    port            => '80',
    docroot         => "${docroot}/sei",
    docroot_owner   => $owner,
    docroot_group   => $owner,
    options         => ['FollowSymLinks'],
    override        => ['All'],
    require         => Class['::apache::mod::prefork'],
    aliases         => [
      {
        alias => '/sip',
        path  => "${docroot}/sip",
      },
      {
        alias => '/infra_js',
        path  => "${docroot}/infra_js",
      },
      {
        alias => '/infra_css',
        path  => "${docroot}/infra_css",
      },
      {
        alias => '/infra_php',
        path  => "${docroot}/infra_php",
      },
    ],
    custom_fragment => "
      php_admin_value post_max_size 1025M
      php_admin_value upload_max_filesize 1024M
      php_admin_value session.gc_maxlifetime 43200
      php_admin_value short_open_tag on
      php_admin_value default_socket_timeout 60
      php_admin_value memory_limit 2048M
      php_admin_value date.timezone America/Sao_Paulo
      php_admin_value max_execution_time 300
      php_admin_value include_path \".:${docroot}/infra_php\"
      AddDefaultCharset iso-8859-1
      ",
  }

  file { $docroot:
    owner   => $owner,
    group   => $group,
    mode    => '0664',
    recurse => true,
  }

  file { $seidados:
    owner   => $owner,
    group   => $group,
    mode    => '0664',
    recurse => true,
  }

  file { "${docroot}/sei/ferramentas/wkhtmltopdf-amd64":
    mode => '0755',
  }

}
