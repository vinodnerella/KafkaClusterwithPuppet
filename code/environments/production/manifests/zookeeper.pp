
#Copying Zookeeper Package to opt folder
$pacakge_zookeeper_name        = 'zookeeper-3.4.12'
$repository_zookeeper_url      = 'http://www-us.apache.org/dist/zookeeper/zookeeper-3.4.12/zookeeper-3.4.12.tar.gz'
$archive_zookeeper_name        = "${pacakge_zookeeper_name}.tgz"
$zookeeper_directory = "$install_path/$pacakge_zookeeper_name"
$config_directory    = "$zookeeper_directory/conf/"
$zookeeper_bin_directory = "$zookeeper_directory/bin/"
$config_file         = "$zookeeper_directory/conf/zoo.cfg"
$log4j_file          = "$zookeeper_directory/conf/log4j.properties"

  archive { $archive_zookeeper_name:
    	path         => "/tmp/${archive_zookeeper_name}",
  	source       => $repository_zookeeper_url,
  	extract      => true,
  	extract_path => $install_path,
  	creates      => "${install_path}/${pacakge_zookeeper_name}",
  	cleanup      => true,
	}

#Creating Group and User zookeeper
  group { 'zookeeper':
      ensure => 'present',
      gid    => '1006',
       }
  user { 'zookeeper':
      ensure           => 'present',
      home             => '/home/zookeeper',
      comment           => 'Added zookeeper user with puppet',
      groups            => 'zookeeper',
      password         => 'itveristy',
      shell            => '/bin/bash',
      uid              => '1006',
      managehome      => true
     }

#Changing the permissions to Zookeeper directory
    exec { 'zookeeper permission':
      command   => "chown -R zookeeper:zookeeper $zookeeper_directory",
      path      => $::path
     }

#Creating Zoo.cfg file and updating the content
file { $config_file:
  ensure => present,
}
exec { 'cp zoo_sample.cfg zoo.cfg':
  cwd     => $config_directory,
  path    => ['/usr/bin', '/usr/sbin'],
}

#Creating Log and Data Directories required for Zookeeper
file{"/var/log/zookeeper":
    ensure  =>  directory,
    owner   =>  'zookeeper',
    group   =>  'zookeeper'
  }

file{"/var/lib/zookeeper":
    ensure => directory,
    owner   =>  'zookeeper',
    group  => 'zookeeper'
  }

#Changing the config that required for zookeeper
#Adding server properties in zoo.cfg file
file_line { 'Append a line to config file':
  path => $config_file,
  line => 'server.1=puppetclient0:2888:3888
server.2=puppetclient1:2888:3888
server.3=puppetclient2:2888:3888',
}

#Updating Data Dir value in zoo.cfg
file_line { 'Change zoo.cfg file':
  path => $config_file,
  line => 'dataDir=/var/lib/zookeeper',
  match   => '^dataDir=',
}

#Updating log directory value in log4j.properties file
file_line { 'Change log4j file':
  path => $log4j_file,
  line => 'zookeeper.log.dir=/var/log/zookeeper',
  match   => '^zookeeper.log.dir=',
}

#Configuring Zookeeper Log value
file_line { 'Zookeeper_Log':
  ensure => present,
  path   => '/etc/bashrc',
  line   => 'export ZOO_LOG_DIR=/var/log/zookeeper',
}

#Starting the Zookeeper service
exec { 'sh zkServer.sh start':
  cwd    => $zookeeper_bin_directory,
  path    => ['/usr/bin', '/usr/sbin'],
  user   => 'zookeeper'
}
