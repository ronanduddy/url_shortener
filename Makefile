.PHONY: run stop reset_db test guard shell bundle build setup

run:
	@docker-compose up web

stop:
	@docker-compose down

reset_db:
	@docker-compose up -d test
	@docker-compose run --rm web bash -c "rails db:reset"

test:
	@docker-compose run --rm test bash -c "rails RAILS_ENV=test db:reset; rspec"

guard:
	@docker-compose run --rm test bash -c "rails RAILS_ENV=test db:reset; guard -c"

shell:
	@docker-compose run --rm web sh

bundle:
	@docker-compose run --rm web bundle

build:
	@docker-compose build

setup: build
	@docker-compose up -d web
	@docker-compose up -d test
	@docker-compose run --rm web bash -c "rails log:clear tmp:clear db:reset assets:precompile"
	@docker-compose up web
