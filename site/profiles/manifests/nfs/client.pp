class profile::nfs::client (

  $mountpoint     = undef,
  $nfs_server     = undef,
  $share_folder   = undef,

){

  include '::nfs::client'

  ::nfs::client::mount { $mountpoint:
    server  => $nfs_server,
    share   => $share_folder,
    options => 'rw',
  }

}
