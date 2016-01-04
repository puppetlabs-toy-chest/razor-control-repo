class profile::motd {

  require epel

  package { 'figlet':
    ensure => installed,
  }

  file { '/etc/motd':
    ensure  => present,
    content => inline_template("<%= %x(figlet $::hostname) %>"),
  }

  file_line { 'motd on ssh login':
    ensure => present,
    path   => '/etc/ssh/sshd_config',
    match  => '^PrintMotd',
    line   => 'PrintMotd yes',
    notify => Service['sshd'],
  }

  if !defined(Service['sshd']) {
    service { 'sshd': ensure => running, }
  }

}
