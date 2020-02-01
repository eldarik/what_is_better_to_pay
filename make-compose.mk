USER = "$(shell id -u):$(shell id -g)"

compose-build:
	docker-compose build

compose:
	docker-compose up app

compose-down:
	docker-compose down -v || true

compose-bash:
	docker-compose run --rm --user=$(USER) app bash

compose-db-init:
	docker-compose run --rm app mix ecto.create
	docker-compose run --rm app mix ecto.migrate

compose-install-mix:
	docker-compose run --rm app mix deps.get

compose-setup: compose-down \
	ansible-development-setup-env \
	compose-build \
	compose-install-mix \
	compose-db-init

compose-console:
	docker-compose run --rm app iex -S mix

compose-test:
	docker-compose run --rm app mix test

compose-restart:
	docker-compose restart

compose-stop:
	docker-compose stop

compose-logs:
	docker-compose logs -f --tail=100
