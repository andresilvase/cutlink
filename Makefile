.PHONY: default build test run docs clean

APP_NAME=cutlink

default: run

run:
	docker compose up -d;go run cmd/main.go