.PHONY: run stop seed guard shell shell_and_db bundle build

run: stop build
	@docker-compose up web

stop:
	sudo chown -R ${USER}:${USER} . # TODO: fix
	@docker-compose down

seed:
	@docker-compose run --rm web bundle exec rails db:seed

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
