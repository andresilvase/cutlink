package routes

import (
	"encoding/json"
	"log/slog"
	"net/http"

	"github.com/andresilvase/cutlink/cmd/api/utils"
	"github.com/andresilvase/cutlink/internal/controller"
	"github.com/andresilvase/cutlink/internal/models"
)

func ShortenLink(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()

	var fullUrl models.FullURL
	if err := json.NewDecoder(r.Body).Decode(&fullUrl); err != nil {
		slog.Error(err.Error())

		utils.SendResponse(
			w,
			utils.Response{Error: "Invalid request: Body malformed"},
			http.StatusBadRequest,
		)

		return
	}

	shortenedURL, err := controller.ShortenURL(fullUrl.URL)

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

	response := models.ShortenedURL{
		ShortenedURL: shortenedURL,
	}

	utils.SendResponse(
		w,
		utils.Response{Data: response},
		http.StatusOK,
	)
}
