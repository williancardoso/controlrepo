class profile::puppet::r10k {

  $version = hiera('profiles::puppet::master::r10k_version')

  file {'/etc/puppetlabs/r10k':
    ensure => directory,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
  }

  class {'::r10k':
    remote   => 'git@github.com:gutocarvalho/pcp-controlrepo.git',
    cachedir => '/opt/puppetlabs/server/data/puppetserver/r10k',
    version  => $version,
  }
}
