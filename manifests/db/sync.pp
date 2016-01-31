#
# Class to execute "ec2api-manage db_sync
#
class ec2api::db::sync {
  exec { 'ec2-api-manage db_sync':
    path        => '/usr/bin',
    refreshonly => true,
    subscribe   => [Package['ec2api'], Ec2api_config['database/connection']],
  }

  Exec['ec2-api-manage db_sync'] ~> Service<| title == 'ec2api' |>
}
