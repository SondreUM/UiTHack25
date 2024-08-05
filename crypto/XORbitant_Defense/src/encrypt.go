package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	thing, err := os.ReadFile("flag.txt")

	// check for error
	if err != nil {
		fmt.Println("Error reading file")
		os.Exit(1)
	}

	thingthing := make([]byte, len(thing))
	for i := 0; i < len(thing); i++ {
		thingthing[i] = thing[i] ^ 0xff
	}
	var something = make([]string, len(thingthing))
	for i := 0; i < len(thingthing); i++ {
		something[i] = strconv.FormatUint(uint64(thingthing[i]), 2)
	}
	result := strings.Join(something, " ")

	err = os.WriteFile("flag.txt.enc", []byte(result), 0644)
}
