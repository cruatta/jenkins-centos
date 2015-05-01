build:
	docker build -t cruatta/jenkins-centos .

run:
	docker run -d -P cruatta/jenkins-centos

buildclean:
	docker build -t cruatta/jenkins-centos --no-cache --rm=true .
