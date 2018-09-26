#In this manifest file we will be performing tasks that specific to each node
#Creating myid file and updating broker.id property in server.properties file in each node with 1,2 and 3
#Performing tasks on Pupper Agent 1: puppetclient0
node 'puppetclient0' {
file { '/var/lib/zookeeper/myid':
  ensure => present,
  content => '1',
  owner  => 'zookeeper',
  group => 'zookeeper'
}

file_line { 'Change server.properties file':
  path => $serverproperties_file,
  line => 'broker.id=1',
  match   => '^broker.id=',
}

}

#Performing tasks on Pupper Agent 2: puppetclient1
node 'puppetclient1' {
file { '/var/lib/zookeeper/myid':
  ensure => present,
  content => '2',
  owner  => 'zookeeper',
  group => 'zookeeper'
}

file_line { 'Change server.properties file':
  path => $serverproperties_file,
  line => 'broker.id=2',
  match   => '^broker.id=',
}
}

#Performing tasks on Pupper Agent 3: puppetclient2
node 'puppetclient2' {
file { '/var/lib/zookeeper/myid':
  ensure => present,
  content => '3',
  owner  => 'zookeeper',
  group => 'zookeeper'
}
file_line { 'Change server.properties file':
  path => $serverproperties_file,
  line => 'broker.id=3',
  match   => '^broker.id=',
}
class { 'java' :
  package => 'java-1.8.0-openjdk-devel',
  }

file { "/etc/profile.d/java_home.sh":
      content => 'export JAVA_HOME="/usr/lib/jvm/jre-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64"'
   }

}

