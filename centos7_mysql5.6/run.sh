#!/bin/bash
export env
echo JAVA_HOME=$JAVA_HOME >> /etc/profile
echo JAVA_HOME=$JAVA_HOME >> /root/.bashrc
echo MAVEN_HOME=$MAVEN_HOME >> /etc/profile
echo MAVEN_HOME=$MAVEN_HOME >> /root/.bashrc
echo PATH=$PATH >> /etc/profile
echo PATH=$PATH >> /root/.bashrc
echo CLASSPATH=$CLASSPATH >> /etc/profile
echo CLASSPATH=$CLASSPATH >> /root/.bashrc
echo "export PATH JAVA_HOME CLASSPATH MAVEN_HOME" >> /etc/profile
echo "export PATH JAVA_HOME CLASSPATH MAVEN_HOME" >> /root/.bashrc
source /etc/profile
source /root/.bashrc
/usr/sbin/sshd -D