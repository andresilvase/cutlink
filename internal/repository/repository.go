package repository

import (
	"context"
	"fmt"
	"log/slog"

	"math/rand"

	"github.com/andresilvase/cutlink/internal"
	"github.com/redis/go-redis/v9"
)

type repository struct {
	rdb *redis.Client
}

type Repository interface {
	SaveShortenedURL(ctx context.Context, fullURL string) (string, error)
}

func New(rdb *redis.Client) Repository {
	return repository{rdb}
}

func genShortenedUrl() string {
	const caracters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJLMNOPQRSTUVWXYZ"
	const size = 8
	byts := make([]byte, size)

	for i := range size {
		randomInt := rand.Intn(len(caracters))
		byts[i] = caracters[randomInt]
	}

	return string(byts)
}

func (s repository) SaveShortenedURL(ctx context.Context, fullURL string) (string, error) {
	var shortenedURL string

	for range 100 {
		shortenedURL = genShortenedUrl()
		_, err := s.rdb.HGet(ctx, "shortener", shortenedURL).Result()
		if err != nil {
			if err == redis.Nil {
				break
			}
			return "", err
		}
		shortenedURL = ""
	}

	if shortenedURL == "" {
		slog.Error("was not possible to short this link now: limit trials reached.")
		return shortenedURL, fmt.Errorf("was not possible to short this link now")
	}

	_, err := s.rdb.HSet(ctx, "shortener", shortenedURL, fullURL).Result()
	if err != nil {
		slog.Error(err.Error())
		return "", fmt.Errorf("error %w tryna shorten this link", err)
	}

	return internal.BASE_URL + shortenedURL, nil
}
