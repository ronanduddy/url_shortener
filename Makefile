.PHONY: run stop reset_db guard shell shell_and_db bundle build

run: stop build
	@docker-compose up web

stop:
	sudo chown -R ${USER}:${USER} . # TODO: fix
	@docker-compose down

reset_db:
	@docker-compose run --rm web bash -c "bundle exec rails db:drop db:create db:migrate db:seed"

guard:
	@docker-compose run --rm test bash -c "bundle exec rails db:drop db:create db:migrate RAILS_ENV=test; bundle exec guard -c"

shell:
	@docker-compose run --rm dev sh

shell_and_db: build
	@docker-compose run --rm web sh

bundle: stop build
	@docker-compose run --rm dev bundle

build:
	@docker-compose build
