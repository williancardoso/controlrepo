class profile::sei::fonts (

  $source   = 'https://downloads.sourceforge.net/project/mscorefonts2/rpms/',
  $pkg      = 'msttcore-fonts-installer-2.6-1.noarch.rpm',

) {

  package { 'openssl': ensure => present, }
  package { 'libxml2': ensure => present, }
  package { 'curl': ensure => present, }
  package { 'cabextract': ensure => present, }
  package { 'xorg-x11-font-utils': ensure => present, }
  package { 'fontconfig': ensure => present, }

  exec { "/usr/bin/wget ${source}/${pkg}":
    creates => "/tmp/${pkg}",
    cwd     => '/tmp'
  }

  package { 'msttcorefonts':
    ensure   => installed,
    provider => 'rpm',
    source   => "/tmp/${pkg}",
  }

}
