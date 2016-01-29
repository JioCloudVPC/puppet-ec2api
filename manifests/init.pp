# == Class: ec2api
#
# Main EC2 API class to configure the service via puppet.
#
class ec2api(
  $ec2api_config = {},
  $api_paste_ini_config ={},
  $manage_service = true,
) {


  validate_hash($ec2api_config)
  validate_hash($api_paste_ini_config)
  validate_bool($manage_service)

  include ec2api::params

  # Install the package
  package { 'ec2api':
    ensure => present,
    name   => $ec2api::params::package_name,
  }

  
  $defaults = {
    notify => Service['ec2api'],
    require => Package['ec2api']
  }

  create_resources(ec2api_config, $ec2api_config, $defaults)
  create_resources(ec2api_api_paste_ini, $api_paste_ini_config, $defaults)

  if $manage_service {
     $srv_status = 'running'
  } else {
     $srv_status = 'stopped'
  }

  service {'ec2api':
    ensure => $srv_status,
    hasrestart => true,
    require => Package['ec2api']
  }
}
