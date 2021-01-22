.PHONY: run stop shell build

run:
	@docker-compose up

stop:
	@docker-compose down

shell:
	@docker-compose run --rm web sh

build:
	@docker-compose build
