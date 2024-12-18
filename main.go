package main

import (
	"fmt"
	"math/rand"
)

func main() {
	const baseUrl = "https://cutli.ink/"
	fmt.Println(baseUrl + genUrl())
}

func genUrl() string {
	const caracters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJLMNOPQRSTUVWXYZ"
	const size = 8
	byts := make([]byte, size)

	for i := range size {
		randomInt := rand.Intn(len(caracters))
		byts[i] = caracters[randomInt]
	}

	return string(byts)
}
