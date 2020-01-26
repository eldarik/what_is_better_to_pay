USER = "$(shell id -u):$(shell id -g)"

compose-build:
	docker-compose build

compose:
	docker-compose up app

compose-bash:
	docker-compose run --user=$(USER) app bash

compose-setup: ansible-development-setup-env \
	compose-build
