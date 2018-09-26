#Download and Untar Kafka
$install_path        = '/opt'
$package_name        = 'kafka_2.11-2.0.0'
$repository_url      = 'http://www-us.apache.org/dist/kafka/2.0.0/kafka_2.11-2.0.0.tgz'
$archive_name        = "${package_name}.tgz"
$kafka_directory = "$install_path/$package_name"
$serverproperties_file         = "$kafka_directory/config/server.properties"
  group { 'kafka':
      ensure => 'present',
      gid    => '1007',
     }
  user { 'kafka':
      ensure           => 'present',
      home             => '/home/kafka',
      comment           => 'Added kafka user with puppet',
      groups            => 'kafka',
      password         => 'itveristy',
      shell            => '/bin/bash',
      uid              => '1007',
      managehome      => true
    }
    archive { $archive_name:
    	path         => "/tmp/${archive_name}",
  	source       => $repository_url,
  	extract      => true,
  	extract_path => $install_path,
  	creates      => "${install_path}/${package_name}",
  	cleanup      => true,
	}

#Changing the permissions to Kafka folder
exec { 'kafka permission':
  command   => "chown -R kafka:kafka $kafka_directory",
  path      => $::path
}

#Updating the server.properties in Kafka config
file_line { 'Change server.properties file with zookeeper.connect':
  path => $serverproperties_file,
  line => 'zookeeper.connect=puppetclient0:2181,puppetclient1:2181,puppetclient2:2181',
  match   => '^zookeeper.connect=',
}
