# DOCKER-VERSION 0.6.1
# VERSION        0.3

FROM ubuntu
MAINTAINER Justin Plock <jplock@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y -q wget maven
RUN wget -q -O /opt/pom.xml https://raw.github.com/Netflix/exhibitor/master/exhibitor-standalone/src/main/resources/buildscripts/standalone/maven/pom.xml
ENV JAVA_HOME /usr/lib/jvm/java-6-openjdk-amd64
RUN cd /opt && mvn assembly:single

EXPOSE 8080
ENTRYPOINT ["/usr/bin/java", "-jar", "/opt/target/exhibitor-war-1.0-jar-with-dependencies.jar"]
CMD ["--help"]
