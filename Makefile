.PHONY: default build test run docs clean

APP_NAME=cutlink

default: run

run:
	@docker compose up -d
	
up:
	docker-compose up --build --force-recreate -d

down:
	docker-compose down

run-local:
	@go run cmd/main.go	