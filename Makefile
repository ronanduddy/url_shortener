.PHONY: run stop guard shell bundle build

run: build
	@docker-compose up

stop:
	sudo chown -R ${USER}:${USER} . # TODO: fix
	@docker-compose down

guard: build
	@docker-compose run --rm test bundle exec guard -c

shell: build
	@docker-compose run --rm dev sh

bundle: stop build
	@docker-compose run --rm dev bundle

build:
	@docker-compose build
