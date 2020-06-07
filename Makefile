IMAGE := qnimbus/docker-travis-cli
VERSION:= $(shell grep DOCKER_TRAVIS_CLI Dockerfile | awk '{print $2}' | cut -d '=' -f 2)

test:
	true

image:
	docker build -t ${IMAGE}:${VERSION} .
	docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

push-image:
	docker push ${IMAGE}:${VERSION}
	docker push ${IMAGE}:latest

push-readme:
	docker-pushrm ${IMAGE}

.PHONY: image push-image push-readme test