package models

type ShortenedURL struct {
	FullURL string `json:"full_url"`
	Code    string `json:"code"`
}

type FullURL struct {
	URL string `json:"url"`
}
