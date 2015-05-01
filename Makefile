build:
	docker build -t cruatta/jenkins-centos .

run:
	docker run -d -P cruatta/jenkins-centos

cleanbuild:
	docker build -t cruatta/jenkins-centos -no-cache -rm=true .
