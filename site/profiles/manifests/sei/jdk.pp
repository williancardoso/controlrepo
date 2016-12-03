class profile:::jdk (

  $version  = 'java-1.7.0-openjdk',

){

  package { $version:
    ensure => present
  }

}
