compose-build:
	docker-compose build

compose:
	docker-compose up app

compose-bash:
	docker-compose run app bash

compose-setup: ansible-development-setup-env \
	compose-build
