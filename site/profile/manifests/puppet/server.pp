class profile::puppet::server {

  $agent_version          = hiera('profile::puppet::agent::agent_version')
  $puppetmaster           = hiera('profile::puppet::agent::puppetserver')
  $puppetmaster_autosign  = hiera('profile::puppet::master::autosign')
  $server_version         = hiera('profile::puppet::master::server_version')
  $puppetdb_server        = hiera('profile::puppet::master::puppetdb_server')
  $puppetdb_version       = hiera('profile::puppet::master::puppetdb_version')

  $jruby_instances = $::processorcount * 2

  firewall { '100 allow puppetserver access':
    dport  => [8140],
    proto  => tcp,
    action => accept,
  }

  $server_java_opts = '-Xms512m -Xmx512m'

  # Bug relacionado: https://tickets.puppetlabs.com/browse/SERVER-557
  file {'/etc/systemd/system/puppetserver.service.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file {'/etc/systemd/system/puppetserver.service.d/local.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "[Service]\nTimeoutStartSec=300\n",
  }

  class {'::puppet':
    server                      => true,
    server_ca_enabled           => true,
    autosign                    => $puppetmaster_autosign,
    runmode                     => 'service',
    server_java_opts            => $server_java_opts,
    server_version              => $server_version,
    agent_version               => $agent_version,
    puppetmaster                => $puppetmaster,
    puppetdb                    => true,
    puppetdb_server             => $puppetdb_server,
    puppetdb_version            => $puppetdb_version,
    server_reports              => ['log', 'puppetdb'],
    server_max_active_instances => $jruby_instances,
  }

}
