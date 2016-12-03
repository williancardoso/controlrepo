class profile::sei::cron (

  $docroot = undef,

){

  cron { 'AgendaTarefaSei':
	  ensure  => 'present',
		command => "/usr/bin/php -c /etc/php.ini ${docroot}/sei/AgendamentoTarefaSEI.php 2>&1 >> /root/infra_agendamento_sei.log",
		minute  => ['00'],
		target  => 'root',
		user    => 'root',
	}

	cron { 'AgendaTarefaSip':
		ensure  => 'present',
		command => "/usr/bin/php -c /etc/php.ini ${docroot}/sip/AgendamentoTarefaSip.php 2>&1 >> /root/infra_agendamento_sip.log",
		minute  => ['00'],
		target  => 'root',
		user    => 'root',
	}

  cron { 'LimpaSEI':
    ensure  => 'present',
    command => "rm ${docroot}/sei/upload/* -r",
    minute  => ['00'],
    target  => 'root',
    user    => 'root',
  }

  cron { 'LimpaSIP':
    ensure  => 'present',
    command => "rm ${docroot}/sip/upload/* -r",
    minute  => ['00'],
    target  => 'root',
    user    => 'root',
  }
}
