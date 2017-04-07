class profile::sei::conf::sei (
  String $docroot            = $::seiaio::params::httpd_sei_docroot,
  String $owner              = $::seiaio::params::httpd_owner,
  String $group              = $::seiaio::params::httpd_group,
  String $sei_mysql_pass     = $::seiaio::params::sei_mysql_pass,
  String $sip_mysql_pass     = $::seiaio::params::sip_mysql_pass,
  String $mysql_ipaddr       = $::seiaio::params::mysql_ipaddr,
  String $dominio            = $::seiaio::params::dominio,
  String $sigla_organizacao  = $::seiaio::params::sigla_organizacao,
  String $nome_organizacao   = $::seiaio::params::nome_organizacao,
  String $seidados           = $::seiaio::params::httpd_sei_dados

) {

  file { "$docroot/sei/ConfiguracaoSEI.php":
    ensure    => 'file',
    mode      => '0664',
    owner     => $owner,
    group     => $group,
    content   => template('seiaio/sei/ConfiguracaoSEI.php.erb'),
  }

}
