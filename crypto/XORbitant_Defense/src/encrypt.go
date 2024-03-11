package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	byteflag, err := os.ReadFile("flag.txt")

	// check for error
	if err != nil {
		fmt.Println("Error reading file")
		os.Exit(1)
	}

	flag := make([]byte, len(byteflag))
	for i := 0; i < len(byteflag); i++ {
		flag[i] = byteflag[i] ^ 0xff
	}
	var bitstringlist = make([]string, len(flag))
	for i := 0; i < len(flag); i++ {
		bitstringlist[i] = strconv.FormatUint(uint64(flag[i]), 2)
	}
	bitstring := strings.Join(bitstringlist, " ")

	err = os.WriteFile("flag.txt.enc", []byte(bitstring), 0644)
}
