class profile::sei::deploy::sip (

  String $docroot       = undef,
  String $git_repo  = undef,

){

  vcsrepo {  $docroot:,
    ensure   => latest,
    provider => git,
    revision => 'master',
    source   => $git_repo
  }

}
