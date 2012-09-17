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
  $sysconfig = false
){
  package{'uwsgi':
    ensure => present,
  }
  service{'uwsgi':
    ensure => running,
    enable => true,
    hasstatus => false,
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
}
