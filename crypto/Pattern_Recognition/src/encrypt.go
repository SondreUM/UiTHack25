package main

import (
	"fmt"
	"os"
	"strings"
)

func encrypt(input string) string {
	var alphabet_lower string = "abcdefghijklmnopqrstuvwxyz"
	var alphabet_upper string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	var ciphertext string = ""
	var index int

	for _, char := range input {
		if 'a' <= char && char <= 'z' {
			// lower case
			index = strings.IndexRune(alphabet_lower, char)
			index = 25 - index
			ciphertext += string(alphabet_lower[index])
		} else if 'A' <= char && char <= 'Z' {
			// upper case
			index = strings.IndexRune(alphabet_upper, char)
			index = 25 - index
			ciphertext += string(alphabet_upper[index])
		} else {
			// non-letter
			ciphertext += string(char)
		}
	}
	return ciphertext
}

func main() {
	// allocate space for flag
	var byteFlag = make([]byte, 100)
	var flag string
	var err error

	// Read flag from file
	file, err := os.Open("../src/flag.txt")
	if err != nil {
		fmt.Println(err)
		return
	}
	var read, _ = file.Read(byteFlag)
	defer file.Close()

	// Convert flag to string and encrypt it
	flag = string(byteFlag[:read])
	fmt.Printf("Flag: %s\n", flag)
	var ciphertext string = encrypt(flag)

	// Create file to store the encrypted flag
	var filename string = "../src/flag.txt.enc"
	file, err = os.Create(filename)
	if err != nil {
		fmt.Println(err)
		return
	}

	// Write encryptet flag to file
	_, err = file.WriteString(ciphertext)
	if err != nil {
		fmt.Println(err)
		return
	}

	defer file.Close()
}
