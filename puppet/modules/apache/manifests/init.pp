# Apache web server with mod_php
class apache {

	package { ['apache2', 'libapache2-mod-php5']:
		ensure  => present,
	}

	file { '/etc/apache2/conf.d/disable-sendfile':
		ensure  => file,
		source  => 'puppet:///modules/apache/disable-sendfile',
		require => Package['apache2'],
		before  => Service['apache2'],
	}

	service { 'apache2':
		ensure     => running,
		require    => Package['apache2', 'libapache2-mod-php5'],
		hasrestart => true,
	}

	exec { 'reload-apache2':
		command     => 'service apache2 reload',
		refreshonly => true,
		before      => Service['apache2'],
	}

}
