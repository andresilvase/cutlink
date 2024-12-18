package repository

import (
	"context"
	"fmt"

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
		_, err := s.rdb.Get(ctx, shortenedURL).Result()
		if err != nil {
			if err == redis.Nil {
				break
			}
			return "", err
		}
	}

	if shortenedURL == "" {
		return shortenedURL, fmt.Errorf("was not possible to shorten this link now, please try again")
	}

	return internal.BASE_URL + shortenedURL, nil
}
