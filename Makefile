CURRENT_DATE := `date + '%Y-%m-%d'`
VERSION ?= $(CURRENT_DATE)

GITHUB_URL := 'https://github.com/Akino1976docker-library.git'

export VERSION

build:
	docker build \
		-t rocker-rbase-ext:latest \
		-t rocker-rbase-ext:$(VERSION)
		-t $(GITHUB_URL)/rocker-rbase-ext \
		-t $(GITHUB_URL)/rocker-rbase-ext:$(VERSION) \
		-t $(GITHUB_URL)/rocker-rbase-ext:$(CURRENT_DATE) \
		-f Dockerfile
		.

date:
	@echo $(CURRENT_DATE)

version:
	@echo $(VERSION)

stop-containers:
	docker-compose kill

clear-containers: stop-containers
	docker-compose rm --force

stop-all-containers:
	docker ps -q | xargs -I@ docker stop @

clear-all-containers: stop-all-containers
	docker ps -aq | xargs -I@ docker rm @

clear-volumes: clear-all-containers
	docker volume ls -q | xargs -I@ docker volume rm @

clear-images: clear-volumes
	docker images -q | uniq | xargs -I@ docker rmi -f @
