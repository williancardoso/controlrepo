class profile::puppetdb::frontend  {

  include profile::puppetdb::apache
  include puppetboard

  $puppetexplorer_version = hiera('profiles::puppetexplorer::version')

  class { 'puppetexplorer':
    package_ensure => $puppetexplorer_version,
    vhost_options  => {
      serveraliases => ["puppetexplorer.${::domain}"],
         'priority' => '05',
          rewrites  => [ { rewrite_rule => ['^/api/metrics/v1/mbeans/puppetlabs.puppetdb.query.population:type=default,name=(.*)$  https://%{HTTP_HOST}/api/metrics/v1/mbeans/puppetlabs.puppetdb.population:name=$1 [R=301,L]'] } ]
    },
  }
}
