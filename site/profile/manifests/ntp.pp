
class profile::ntp {

  class { '::ntp':
    servers => [ 'a.ntp.br', 'b.ntp.br', 'c.ntp.br' ],
  }
}

