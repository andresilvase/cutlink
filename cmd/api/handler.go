package api

import (
	"net/http"

	"github.com/andresilvase/cutlink/cmd/api/routes"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func handler() http.Handler {
	handler := chi.NewMux()

	handler.Use(middleware.Recoverer)
	handler.Use(middleware.RequestID)
	handler.Use(middleware.Logger)

	handler.Route("/", func(r chi.Router) {
		r.Get("/{:[a-zA-Z0-9]+}", routes.GetFullURL)
		r.Post("/cut", routes.ShortenLink)
	})

	return handler
}
