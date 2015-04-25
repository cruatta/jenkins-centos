build:
	docker build -t cruatta/jenkins-centos .

run:
	docker run -d -P cruatta/jenkins-centos
