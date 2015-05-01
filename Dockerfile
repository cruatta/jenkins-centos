FROM centos:6
MAINTAINER Cameron Ruatta cameron@ruatta.com

ENV JENKINS_HOME /var/lib/jenkins
ADD start.sh /start.sh 
RUN chmod +x /start.sh 
RUN yum install -y wget java-1.8.0-openjdk curl
RUN rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN yum install -y jenkins
RUN touch /var/log/jenkins/jenkins.log
RUN chown -R jenkins:jenkins /var/log/jenkins/
ADD tcp-slave-agent-port.groovy /tcp-slave-agent-port.groovy
ADD init.sh /init.sh
RUN chmod +x /init.sh
RUN /init.sh

ONBUILD ADD config /config
ONBUILD ADD setup.sh /config/setup.sh
ONBUILD RUN chmod +x /config/setup.sh
ONBUILD RUN /config/setup.sh 

EXPOSE 8080
EXPOSE 50000
ENTRYPOINT ["/bin/bash"]
CMD ["/start.sh"]
