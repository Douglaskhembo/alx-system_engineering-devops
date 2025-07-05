# 2-puppet_custom_http_response_header.pp
# This Puppet manifest installs Nginx and adds a custom HTTP response header X-Served-By with the server's hostname

package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  require    => Package['nginx'],
}

file_line { 'add custom header to nginx config':
  path  => '/etc/nginx/sites-available/default',
  line  => '    add_header X-Served-By $hostname;',
  match => '^\s*add_header X-Served-By',
  after => '^\s*server_name _;',
  require => Package['nginx'],
  notify  => Service['nginx'],
}
