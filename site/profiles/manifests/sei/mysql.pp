class profile::sei::mysql (

  String $root_mysql        = undef,
  String $sei_mysql_pass    = undef,
  String $sip_mysql_pass    = undef,
  String $mysql_ipaddr      = undef,
  String $sigla_organizacao,
  String $nome_organizacao,
  String $dominio,

) {

    class { 'mysql::server':
      root_password    => $root_mysql,
      override_options => {
        'mysqld' => {
          'bind_address' => '0.0.0.0',
        }
      }
    }

    mysql::db { 'sei':
      user     => 'user_sei',
      password => $sei_mysql_pass,
      host     => 'localhost',
      charset  => 'latin1',
      collate  => 'latin1_swedish_ci',
      grant    => ['all'],
      notify   => Exec['popula_sei']
    }

    exec { 'popula_sei':
      command     => "mysql -h ${mysql_ipaddr} -u user_sei -p${sei_mysql_pass} sei < ${::fontes::params::httpd_sei_docroot}/db/sei_2_6_0.sql",
      path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      refreshonly => true,
      notify      => Exec['sei_sigla_organizacao']
    }

    exec { 'sei_sigla_organizacao':
      command     => "mysql -h ${mysql_ipaddr} -u user_sei -p${sei_mysql_pass} sei -e \"update orgao set sigla='${sigla_organizacao}', descricao='${nome_organizacao}' where id_orgao=0;\"",
      path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      refreshonly => true,
      notify      => Exec['sip_seta_pagina_sip']
    }

    mysql::db { 'sip':
      user     => 'user_sip',
      password => $sip_mysql_pass,
      host     => 'localhost',
      charset  => 'latin1',
      collate  => 'latin1_swedish_ci',
      grant    => ['all'],
      notify   => Exec['popula_sip']
    }

    exec { 'popula_sip':
      command     => "mysql -h ${mysql_ipaddr} -u user_sip -p${sip_mysql_pass} sip < ${::fontes::params::httpd_sei_docroot}/db/sip_2_6_0.sql",
      path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      refreshonly => true,
      notify      => Exec['sip_sigla_organizacao']
    }

    exec { 'sip_sigla_organizacao':
      command     => "mysql -h ${mysql_ipaddr} -u user_sip -p${sip_mysql_pass} sip -e \"update orgao set sigla='${sigla_organizacao}', descricao='${nome_organizacao}' where id_orgao=0;\"",
      path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      refreshonly => true,
      notify      => Exec['sip_seta_pagina_sip']
    }

    exec { 'sip_seta_pagina_sip':
      command     => "mysql -h ${mysql_ipaddr} -u user_sip -p${sip_mysql_pass} sip -e \"update sistema set pagina_inicial='http://${dominio}/sip' where sigla='SIP';\"",
      path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      refreshonly => true,
      notify      => Exec['sip_seta_pagina_sei']
    }

    exec { 'sip_seta_pagina_sei':
      command     => "mysql -h ${mysql_ipaddr} -u user_sip -p${sip_mysql_pass} sip -e \"update sistema set pagina_inicial='http://${dominio}/inicializar.php', web_service='http://${dominio}/controlador_ws.php?servico=sip' where sigla='SEI'\"",
      path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      refreshonly => true,
    }
}
