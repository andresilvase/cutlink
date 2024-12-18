package controller

import (
	"context"
	"log/slog"

	"github.com/andresilvase/cutlink/internal/repository"
	"github.com/redis/go-redis/v9"
)

var store = repository.New(
	redis.NewClient(&redis.Options{Addr: "localhost:6379"}),
)

func ShortenURL(fullURL string) (string, error) {
	ctx := context.Background()
	shortenedURL, err := store.SaveShortenedURL(ctx, fullURL)

	if err != nil {
		slog.Error(err.Error())
		return "", err
	}

	return shortenedURL, nil
}
