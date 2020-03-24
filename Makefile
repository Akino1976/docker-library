CURRENT_DATE := `date +'%Y-%m-%d'`
VERSION ?= $(CURRENT_DATE)

DOCKER_HUB := 'docker.io/akino1976'
export VERSION

build:
	docker build \
		-t databricks-rbase:latest \
		-t databricks-rbase:$(VERSION) \
		-t $(DOCKER_HUB)/databricks-rbase \
		-t $(DOCKER_HUB)/databricks-rbase:$(VERSION) \
		-t $(DOCKER_HUB)/databricks-rbase:$(CURRENT_DATE) \
		-f Dockerfile \
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
