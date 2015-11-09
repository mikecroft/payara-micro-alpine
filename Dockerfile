# Pull Zulu8 image.
FROM azul/zulu-openjdk:8

# Maintainer
# ----------
MAINTAINER Mike Croft <mike.croft@payara.co>

# Set ENV vars
ENV PAYARA_PKG http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=fish.payara.extras&a=payara-micro&v=LATEST
ENV PKG_FILE_NAME payara-micro.jar
ENV DEPLOY_DIR /opt/payara-micro-wars
ENV JCACHE_WAR https://s3-eu-west-1.amazonaws.com/devoxx2015/BE/rest-jcache.war
ENV HZ_CONFIG https://gist.githubusercontent.com/mikecroft/b42077bb540711e7ff18/raw/b870a5ba14680e00c0cb91ed20a8db6f2e781089/hazelcast.xml

# Install packages on ubuntu base image
 RUN \
  apt-get update && \
  apt-get install -y wget && \
  apt-get install -y software-properties-common python-software-properties


# Add payara user, download payara micro build. Download sample war app and package on image.
RUN useradd -b /opt -m -s /bin/bash payara && echo payara:payara | chpasswd
RUN cd /opt && wget $PAYARA_PKG -O $PKG_FILE_NAME
RUN mkdir -p $DEPLOY_DIR
RUN chown -R payara:payara /opt

# Download resources
RUN wget $JCACHE_WAR -P $DEPLOY_DIR
RUN wget $HZ_CONFIG -P /opt

# Set up payara user and the home directory for the user
USER payara
WORKDIR /opt
ENTRYPOINT ["java", "-jar", "payara-micro.jar", "--deploymentDir", $DEPLOY_DIR]
