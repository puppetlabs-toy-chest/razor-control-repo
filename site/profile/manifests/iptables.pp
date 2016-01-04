class profile::iptables {

  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }

  package { 'iptables-services':
    ensure => installed,
  }

  service { ['iptables', 'ip6tables']:
    ensure => running,
    enable => true,
  }

}
