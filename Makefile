.PHONY: run stop guard shell build

APP=dev
RUN=@docker-compose run --rm ${APP}

run: build
	@docker-compose up

stop:
	@docker-compose down

guard: build
	${RUN} bundle exec guard -c

shell: build
	${RUN} sh

build:
	@docker-compose build
