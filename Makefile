.PHONY: run stop guard shell shell_and_db bundle build

run: build
	@docker-compose up web

stop:
	sudo chown -R ${USER}:${USER} . # TODO: fix
	@docker-compose down

guard: build
	@docker-compose run --rm test bundle exec guard -c

shell: build
	@docker-compose run --rm dev sh

shell_and_db: build
	@docker-compose run --rm web sh

bundle: stop build
	@docker-compose run --rm dev bundle

build:
	@docker-compose build
