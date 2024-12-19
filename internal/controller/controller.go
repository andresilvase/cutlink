package controller

import (
	"context"

	"github.com/andresilvase/cutlink/internal/repository"
	"github.com/redis/go-redis/v9"
)

var store = repository.New(
	redis.NewClient(&redis.Options{Addr: "localhost:6379"}),
)

func ShortenURL(fullURL string) (string, error) {
	ctx := context.Background()

	return store.SaveShortenedURL(ctx, fullURL)
}

func FullURL(shortenedURL string) (string, error) {
	ctx := context.Background()

	return store.FullURL(ctx, shortenedURL)
}
