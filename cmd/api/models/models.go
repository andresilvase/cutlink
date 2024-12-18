package models

type ShortenedURL struct {
	Code string `json:"code"`
}

type FullURL struct {
	URL string `json:"url"`
}
