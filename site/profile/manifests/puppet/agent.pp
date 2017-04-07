class profile::puppet::agent {

  $agent_version  = hiera('profile::puppet::agent::agent_version')
  $puppetmaster   = hiera('profile::puppet::agent::puppetserver')

  class { 'puppet':
    runmode       => 'service',
    certname      => $::trusted['certname'],
    agent_version => $agent_version,
    puppetmaster  => $puppetmaster,
  }

}
