package routes

import (
	"log/slog"
	"net/http"

	"github.com/andresilvase/cutlink/cmd/api/utils"
	"github.com/andresilvase/cutlink/internal/controller"
	"github.com/andresilvase/cutlink/internal/models"
	"github.com/go-chi/chi/v5"
)

func FullURL(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()

	shortenedUrlParameter := chi.URLParam(r, "shortenedUrl")

	fullURL, err := controller.FullURL(shortenedUrlParameter)

	if err != nil {
		slog.Error(err.Error())
		utils.SendResponse(
			w,
			utils.Response{
				Error: err.Error(),
			},
			http.StatusInternalServerError,
		)
		return
	}

	response := models.FullURL{
		URL: fullURL,
	}

	utils.SendResponse(
		w,
		utils.Response{
			Data: response,
		},
		http.StatusOK,
	)
}
