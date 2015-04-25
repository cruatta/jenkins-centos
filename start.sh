#!/bin/sh
service jenkins start && tail -f /var/log/jenkins/jenkins.log
