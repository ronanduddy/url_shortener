.PHONY: run stop shell

run:
	@docker-compose up

stop:
	@docker-compose down

shell:
	@docker-compose run --rm web sh
