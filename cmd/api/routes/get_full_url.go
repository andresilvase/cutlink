package routes

import (
	"errors"
	"log/slog"
	"net/http"

	"github.com/andresilvase/cutlink/cmd/api/utils"
	"github.com/andresilvase/cutlink/internal/controller"
	apperrors "github.com/andresilvase/cutlink/internal/errors"
	"github.com/andresilvase/cutlink/internal/models"
	"github.com/go-chi/chi/v5"
)

func FullURL(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()

	shortenedUrlParameter := chi.URLParam(r, "shortenedUrl")

	fullURL, err := controller.FullURL(shortenedUrlParameter)

	if err != nil {
		statusCode := http.StatusInternalServerError
		msgError := err.Error()
		slog.Error(msgError)

		if errors.As(err, &apperrors.NotFound{}) {
			statusCode = http.StatusNotFound
		}

		utils.SendResponse(
			w,
			utils.Response{Error: msgError},
			statusCode,
		)
		return
	}

	response := models.FullURL{
		URL: fullURL,
	}

	http.Redirect(
		w,
		r,
		response.URL,
		http.StatusFound,
	)
}
