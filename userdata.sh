#!/bin/bash

##########################################
# Setting properties
#
# Payara directory
PAYARA_HOME=/opt/payara
MICRO=https://s3-eu-west-1.amazonaws.com/payara.co/payara-micro-prerelease.jar
#
##########################################

echo "Provisioning Payara Micro to $PAYARA_HOME"

# Download and unzip to /opt/payara
echo "running update..."
sudo apt-get -qqy update                      # Update the repos 

echo "installing openjdk"
sudo apt-get -qqy install openjdk-7-jdk       # Newest JDK in 14.04 LTS repos 

echo "Downloading Payara $PAYARA_VERSION"
wget -q $MICRO 
sudo mkdir -p $PAYARA_HOME
mv payara-micro-prerelease.jar $PAYARA_HOME
sudo chown -R ubuntu:ubuntu /opt/payara

wget https://gist.githubusercontent.com/mikecroft/b42077bb540711e7ff18/raw/b870a5ba14680e00c0cb91ed20a8db6f2e781089/hazelcast.xml -P /opt/payara/

wget https://s3-eu-west-1.amazonaws.com/devoxx2015/BE/rest-jcache.war -P /opt/payara

java -jar /opt/payara/payara-micro-prerelease.jar --autoBindHttp --hzConfigFile /opt/payara/hazelcast.xml --deploy rest-jcache.war
