class profile::sei::solr (

  String $dominio,

) {

  require profile::sei::jdk

  group { 'solr':
    ensure => 'present',
  }

  user { 'solr':
    ensure  => 'present',
    home    => '/opt/solr/app',
    shell   => '/bin/bash',
  }

  file {'/etc/default/jetty':
    ensure  => 'file',
    owner   => 'solr',
    group   => 'solr',
    mode    => '0644',
    source  => 'puppet:///modules/seiaio/solr/jetty',
  }

  file {'/etc/init.d/apachesolr':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0751',
    source  => 'puppet:///modules/seiaio/solr/initd',
  }

  file {'/var/log/solr':
    ensure  => 'directory',
    recurse => true,
    owner   => 'solr',
    group   => 'solr',
  }

  file { '/opt/solr':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'solr',
    group   => 'solr',
  }

  file { '/opt/solr/solr.tar':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'solr',
    group   => 'solr',
    source  => 'puppet:///modules/seiaio/solr/solr.tar',
  }

  exec { 'extrai_solr':
    command => 'tar xf solr.tar;chown -R solr.solr /opt/solr',
    cwd     => '/opt/solr',
    creates => '/opt/solr/app',
    path    => ['/bin', '/usr/bin', '/usr/sbin', '/usr/local/bin'],
  }

  file {'/opt/solr/app/solr-daemon.sh':
    ensure  => 'file',
    owner   => 'solr',
    group   => 'solr',
    mode    => '0751',
    source  => 'puppet:///modules/seiaio/solr/solr-daemon',
  }

  file { '/opt/solr/indices':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'solr',
    group   => 'solr',
  }

    # indice protocolos

  file { '/opt/solr/indices/sei-protocolos':
    ensure  => 'directory',
    mode    => '0644',
    owner   => 'solr',
    group   => 'solr',
  }

  file { '/opt/solr/indices/sei-protocolos/conf':
    ensure  => 'directory',
    mode    => '0644',
    owner   => 'solr',
    group   => 'solr',
    source  => "puppet:///modules/seiaio/solr/conf",
    recurse => true,
    force   => true,
  }

  file { '/opt/solr/indices/sei-protocolos/conteudo':
    ensure  => 'directory',
    mode    => '0644',
    owner   => 'solr',
    group   => 'solr',
  }

  file { '/opt/solr/indices/sei-protocolos/contrib':
    ensure  => link,
    target  => '/opt/solr/app/contrib',
  }

  file { '/opt/solr/indices/sei-protocolos/dist':
    ensure  => link,
    target  => '/opt/solr/app/dist',
  }

  file { '/opt/solr/indices/sei-protocolos/lib':
    ensure  => link,
    target  => '/opt/solr/app/example/lib',
  }

  file { '/opt/solr/app/example/solr/sei-protocolos':
    ensure  => link,
    target  => '/opt/solr/indices/sei-protocolos',
  }

  file { '/opt/solr/indices/sei-protocolos/conf/sei-protocolos-config.xml':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'solr',
    group   => 'solr',
    source  => 'puppet:///modules/seiaio/solr/xml/sei-protocolos-config.xml',
  }

  file { '/opt/solr/indices/sei-protocolos/conf/sei-protocolos-schema.xml':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'solr',
    group   => 'solr',
    source  => 'puppet:///modules/seiaio/solr/xml/sei-protocolos-schema.xml',
  }

    # indice base de conhecimento

  file { '/opt/solr/indices/sei-bases-conhecimento':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'solr',
    group   => 'solr',
  }

  file { '/opt/solr/indices/sei-bases-conhecimento/conf':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'solr',
    group   => 'solr',
    source  => "puppet:///modules/seiaio/solr/conf",
    recurse => true,
    force   => true,
  }

  file { '/opt/solr/indices/sei-bases-conhecimento/conteudo':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'solr',
    group   => 'solr',
  }

  file { '/opt/solr/indices/sei-bases-conhecimento/contrib':
    ensure  => link,
    target  => '/opt/solr/app/contrib',
  }

  file { '/opt/solr/indices/sei-bases-conhecimento/dist':
    ensure  => link,
    target  => '/opt/solr/app/dist',
  }

  file { '/opt/solr/indices/sei-bases-conhecimento/lib':
    ensure  => link,
    target  => '/opt/solr/app/example/lib',
  }

  file { '/opt/solr/app/example/solr/sei-bases-conhecimento':
    ensure  => link,
    target  => '/opt/solr/indices/sei-bases-conhecimento',
  }

  file { '/opt/solr/indices/sei-bases-conhecimento/conf/sei-bases-conhecimento-config.xml':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'solr',
    group   => 'solr',
    source  => 'puppet:///modules/seiaio/solr/xml/sei-bases-conhecimento-config.xml',
  }

  file { '/opt/solr/indices/sei-bases-conhecimento/conf/sei-bases-conhecimento-schema.xml':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'solr',
    group   => 'solr',
    source  => 'puppet:///modules/seiaio/solr/xml/sei-bases-conhecimento-schema.xml',
  }

  # indices sei publicacao

  file { '/opt/solr/indices/sei-publicacoes':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'solr',
    group   => 'solr',
  }

  file { '/opt/solr/indices/sei-publicacoes/conf':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'solr',
    group   => 'solr',
    source  => "puppet:///modules/seiaio/solr/conf",
    recurse => true,
    force   => true,
  }

  file { '/opt/solr/indices/sei-publicacoes/conteudo':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'solr',
    group   => 'solr',
  }

  file { '/opt/solr/indices/sei-publicacoes/contrib':
    ensure  => link,
    target  => '/opt/solr/app/contrib',
  }

  file { '/opt/solr/indices/sei-publicacoes/dist':
    ensure  => link,
    target  => '/opt/solr/app/dist',
  }

  file { '/opt/solr/indices/sei-publicacoes/lib':
    ensure  => link,
    target  => '/opt/solr/app/example/lib',
  }

  file { '/opt/solr/app/example/solr/sei-publicacoes':
    ensure  => link,
    target  => '/opt/solr/indices/sei-publicacoes',
  }

  file { '/opt/solr/indices/sei-publicacoes/conf/sei-publicacoes-config.xml':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'solr',
    group   => 'solr',
    source  => 'puppet:///modules/seiaio/solr/xml/sei-publicacoes-config.xml',
  }

  file { '/opt/solr/indices/sei-publicacoes/conf/sei-publicacoes-schema.xml':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'solr',
    group   => 'solr',
    source  => 'puppet:///modules/seiaio/solr/xml/sei-publicacoes-schema.xml',
  }

  service { 'apachesolr':
    ensure  => running,
    enable  => true,
    status  => 'ps -ef | grep solr.home | grep -qv grep',
  }

  file { '/usr/local/bin/solr_cria_indices.sh':
    ensure    => 'file',
    mode      => '0750',
    owner     => 'root',
    group     => 'root',
    content   => template('seiaio/solr/cria_indices.sh.erb'),
  }

  file { '/usr/local/etc/solr_status':
    ensure  => 'file',
    content => 'Arquivo de controle do Solr',
    notify  => Exec['cria_indices_solr'],
  }

  exec { 'cria_indices_solr':
    command     => 'sleep 10;/usr/local/bin/solr_cria_indices.sh',
    path        => ['/bin', '/usr/bin', '/usr/sbin', '/usr/local/bin'],
    refreshonly => true,
  }

}
