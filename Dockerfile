FROM chnoumis/base-jdk:2.7.1

MAINTAINER chnoumis

ENV MAVEN_MAJOR 3
ENV MAVEN_VERSION 3.2.5
ENV DEPLOY_DIR /opt/chnoumis/deploy
ENV STI_SCRIPTS_URL https://raw.githubusercontent.com/chnoumis/docker-base-sti/master/.sti/bin/
USER root

RUN  \
  wget -q -O - http://www.us.apache.org/dist/maven/maven-$MAVEN_MAJOR/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzf - -C /opt/chnoumis \
  && mv /opt/chnoumis/apache-maven-$MAVEN_VERSION /opt/chnoumis/maven \
  && mkdir -p /opt/chnoumis/deploy \
  && chown -R chnoumis:chnoumis /opt/chnoumis \
  && chmod -R 775 /opt/chnoumis/maven/ \
  && ln -sf /opt/chnoumis/maven/bin/mvn /usr/local/bin/mvn

# Configure Source-To-Image scripts
ADD ./bin /usr/bin/

VOLUME ["/opt/maven/repository"]

USER chnoumis

CMD ["/usr/bin/sti-helper"]
