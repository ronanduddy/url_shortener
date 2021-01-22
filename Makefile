.PHONY: run stop guard shell build

run: build
	@docker-compose up

stop:
	@docker-compose down

guard: build
	@docker-compose run --rm test bundle exec guard -c

shell: build
	@docker-compose run --rm dev sh

build:
	@docker-compose build
