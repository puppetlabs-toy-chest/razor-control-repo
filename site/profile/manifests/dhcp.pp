class profile::dhcp (
  $razor_server_ip = '',
){

  class { 'dhcp':
    service_ensure => running,
    dnsdomain      => [
      'puppetlabs.demo',
    ],
    nameservers  => ['8.8.8.8'],
    interfaces   => ['eth1'],
    extra_config  => @("EOF")
      next-server ${razor_server_ip};
      if exists user-class and option user-class = "iPXE" {
          filename "bootstrap.ipxe";
      } else {
          filename "undionly.kpxe";
      }
      | EOF
  }

  dhcp::pool{ 'puppetlabs.demo':
    network => '10.20.1.0',
    mask    => '255.255.255.0',
    range   => ['10.20.1.150', '10.20.1.200'],
  }

}
