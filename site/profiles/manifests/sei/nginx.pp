class profile::sei::nginx (

  $members    = ['localhost:3000','localhost:3001','localhost:3002',],
  $balancer   = 'balancer-sei',
  $url        = undef,

){

  class { 'nginx': }

  nginx::resource::upstream { $balancer:
    members => $members,
  }

  nginx::resource::vhost { $url:
    proxy => "http://${balancer}",
  }

}
