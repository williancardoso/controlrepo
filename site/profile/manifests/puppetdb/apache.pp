class profile::puppetdb::apache {

  $vhost_name = hiera('profiles::puppetdb::puppetdb_server_hostname')

  firewall { '100 allow puppetdb':
    dport  => [80, 443],
    proto  => tcp,
    action => accept,
  }

  class { 'apache':
    default_vhost => false,
  }

  apache::vhost { "${vhost_name}_default":
    servername => $vhost_name,
    port       => '80',
    docroot    => '/var/www/html',
    priority   => '05',
    rewrites   => [
        {
          comment      => '# This will enable the Rewrite to HTTPS',
          rewrite_cond => ['%{HTTPS} !=on'],
          rewrite_rule => ['^/?(.*) https://%{SERVER_NAME}/$1 [R,L]'],
        },
      ],
  }

}
