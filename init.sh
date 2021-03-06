#!/bin/bash
# Start jenkins once to build the default config structure
service jenkins start
while true; do
	if [[ -d $JENKINS_HOME/plugins ]]; then
		break
	else
		echo "Waiting for Jenkins to start for the first time..." && sleep 5
	fi
done

# Register our default plugins
if [[ -d $JENKINS_HOME/plugins ]]; then 
	echo "Adding default plugins to the container"
	cd $JENKINS_HOME/plugins
	wget https://updates.jenkins-ci.org/download/plugins/scm-api/0.2/scm-api.hpi
	wget https://updates.jenkins-ci.org/download/plugins/git-client/1.16.1/git-client.hpi
	wget https://updates.jenkins-ci.org/download/plugins/github-api/1.67/github-api.hpi
	wget https://updates.jenkins-ci.org/download/plugins/github/1.11.3/github.hpi
	wget https://updates.jenkins-ci.org/download/plugins/git/2.3.5/git.hpi
	wget https://updates.jenkins-ci.org/download/plugins/artifactory/2.3.0/artifactory.hpi
	wget https://updates.jenkins-ci.org/download/plugins/scp/1.8/scp.hpi
	service jenkins reload
else
	echo "$JENKINS_HOME/plugins does not exist. Jenkins probably failed to start for the first time"
	exit 1
fi

# Setup the tcp slave
mkdir $JENKINS_HOME/init.groovy.d
echo "Adding tcp slave configuration"
cp /tcp-slave-agent-port.groovy $JENKINS_HOME/init.groovy.d/tcp-slave-agent-port.groovy
service jenkins reload

service jenkins stop
