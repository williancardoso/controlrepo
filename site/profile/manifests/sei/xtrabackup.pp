class profile::sei::xtrabackup (

){

  class { ::xtrabackup:
    backup_dir => '/mnt/backup/',
    mysql_user => 'backup_user',
    mysql_pass => 'backup_password'
  }

}
