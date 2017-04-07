class profile::puppet::r10k {

  $version = hiera('profile::puppet::master::r10k_version')
  $repo_control = hiera('profile::puppet::repo_control') 

  class {'::r10k':
    remote   => $repo_control,
    cachedir => '/opt/puppetlabs/server/data/puppetserver/r10k',
    version  => $version,
  }
}
