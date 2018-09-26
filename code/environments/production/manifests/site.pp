#Install java in all agents

class { 'java' :
  package => 'java-1.8.0-openjdk-devel',
  }

file { "/etc/profile.d/java_home.sh":
      content => 'export JAVA_HOME="/usr/lib/jvm/jre-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64"'
   }

