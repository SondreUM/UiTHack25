package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	// Read the bitstring from the file
	xorflag, err := os.ReadFile("../src/flag.txt.enc")
	if err != nil {
		fmt.Println("Error reading file")
		os.Exit(1)
	}

	// convert the bitstring to a uint64 array
	var flag = strings.Split(string(xorflag), " ")
	byteflag := make([]uint64, len(flag))
	for i := 0; i < len(flag); i++ {
		byteflag[i], err = strconv.ParseUint(flag[i], 2, 8)
	}

	// flip all bits in the flag
	for i := 0; i < len(byteflag); i++ {
		byteflag[i] = byteflag[i] ^ 0xff
	}

	// convert flag to bytes
	var strflag = make([]byte, len(byteflag))
	for i := 0; i < len(byteflag); i++ {
		strflag[i] = byte(byteflag[i])
	}

	// print flag as a string
	fmt.Print(string(strflag[:]))
}
