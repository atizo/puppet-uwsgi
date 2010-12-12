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

class uwsgi {
  package{'uwsgi':
    ensure => present,
  }
  service{'uwsgi':
    ensure => running,
    enable => true,
    hasstatus => true,
    require => [
      Package['uwsgi'],
      File['/etc/sysconfig/uwsgi'],
    ],
  }
  file{'/etc/sysconfig/uwsgi':
    source => [
      "puppet://$source/modules/site-uwsgi/$fqdn/uwsgi.sysconfig",
      "puppet://$source/moduels/site-uwsgi/uwsgi.sysconfig",
      "puppet://$source/modules/uwsgi/uwsgi.sysconfig",
    ],
    require => Package['uwsgi'],
    notify => Service['uwsgi'],
    owner => root, group => root, mode => 0444;
  }
}
