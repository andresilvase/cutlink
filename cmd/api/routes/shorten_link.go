package routes

import (
	"encoding/json"
	"log/slog"
	"net/http"

	"github.com/andresilvase/cutlink/cmd/api/models"
	"github.com/andresilvase/cutlink/cmd/api/utils"
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

}
