# Makefile


## Show this help
.PHONY: help
help:
	@echo 'Usage:'
	@grep -E '^[a-zA-Z0-9_/.-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf " %-24s %s\n", $$1, $$2}'


.PHONY: confirm
	confirm:
	@echo -n 'Are you sure? [y/N] ' && read ans && [ $${ans:-N} = y ]
	

.PHONY: run/api
run/api:
	go run ./cmd/api

## Connect to database using psql
.PHONY: db/psql
db/psql:
	psql ${GREENLIGHT_DB_DSN}

## Create a new migration, pass like 'make db/migrations/new name=xyz'
.PHONY: db/migrations/new
db/migrations/new:
	@echo 'Creating migration files for ${name}...'
	migrate create -seq -ext=.sql -dir=./migrations ${name}


## Run all up migrations
.PHONY: db/migrations/up
db/migrations/up: confirm
	@echo 'Running up migrations...'
	migrate -path ./migrations -database ${GREENLIGHT_DB_DSN} up
