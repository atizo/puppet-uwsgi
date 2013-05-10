#
# uwsgi module
#
# Copyright 2010, Atizo AG
# Simon Josi simon.josi+puppet(at)atizo.com
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class uwsgi(
  $version = 1.9.8,
  $sysconfig = false
){
  python::pip{'uwsgi':
    ensure => installed,
    version = $version,
  }
  service{'uwsgi':
    ensure => running,
    enable => true,
    hasstatus => false,
    status => "pgrep uwsgi",
    require => Package['uwsgi'],
  }
  if $sysconfig {
    file{'/etc/sysconfig/uwsgi':
      content => template('uwsgi/sysconfig.erb'),
      require => Package['uwsgi'],
      notify => Service['uwsgi'],
      owner => root, group => root, mode => 0444;
    }
  }
  file{'/etc/rc.d/init.d/uwsgi':
    source => [
      "puppet://$server/modules/site-uwsgi/$fqdn/uwsgi",
      "puppet://$server/modules/site-uwsgi/$operatingsystem/uwsgi",
      "puppet://$server/modules/site-uwsgi/uwsgi",
      "puppet://$server/modules/uwsgi/$operatingsystem/uwsgi",
      "puppet://$server/modules/uwsgi/uwsgi",
    ],
    require => Python::Pip['uwsgi'],
    notify => Service['uwsgi'],
    owner => root, group => 0, mode => 0644;
  }
}
