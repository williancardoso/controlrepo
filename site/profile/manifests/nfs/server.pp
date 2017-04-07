class profile::nfs::server (

  $share_folder   = undef,
  $clients_ip     = undef,
  $options        = 'rw,insecure,async,no_root_squash',

){

  include nfs::server

  ::nfs::server::export{ $share_folder:
    ensure  => 'mounted',
    clients => "${clients_ip}(${options}) localhost(rw)"
  }

}
