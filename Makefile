.PHONY: default build test run docs clean

APP_NAME=cutlink

default: run

run:
	@docker compose up -d
	
it-all:
	docker-compose build --no-cache;docker compose up -d

down:
	docker-compose down

run-local:
	@go run cmd/main.go	