class profile::razor {
  #Install razor
  include pe_razor

  #Setup tftp boot files
  include tftp

  tftp::file { 'undionly.kpxe': }
  $int1 = keys($::networking['interfaces'])[1]

  #File needs to be dynamically generated
  exec { 'get bootstrap.ipxe from razor server' :
    command   => "/usr/bin/wget --no-check-certificate 'https://${$::networking['interfaces'][$int1]['ip']}:8151/api/microkernel/bootstrap?nic_max=1&http_port=8150' -O /var/lib/tftpboot/bootstrap.ipxe",
    tries     => 10,
    try_sleep => 30,
    unless    => '/usr/bin/test -s /var/lib/tftpboot/bootstrap.ipxe',
  }


}
