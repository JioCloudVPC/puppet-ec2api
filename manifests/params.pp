# == Class: ec2api::params
#
# These parameters need to be accessed from several locations and
# should be considered to be constant
class ec2api::params {
  $package_name          = 'ec2api'
  $api_service_name      = 'ec2api'
  $ec2api_config         = '/etc/ec2api/ec2api.conf'
  $ec2api_api_paste_ini  = '/etc/ec2api/api-paste.ini'
  $s3_service_name       = 'openstack-ec2-api-s3'
  $metadata_service_name = 'openstack-ec2-api-metadata'
}
