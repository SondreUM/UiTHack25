package main

import (
	"fmt"
	"os"
	"strings"
)

// Function to decode a string using the Caesar cipher
func decrypt(input string, shift int) string {
	var alphabet_lower string = "abcdefghijklmnopqrstuvwxyz"
	var alphabet_upper string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	var flag string = ""
	var index int

	for _, char := range input {
		if 'a' <= char && char <= 'z' {
			// lower case
			index = strings.IndexRune(alphabet_lower, char)

			// compensate for go not handling negative numbers with modulo
			index = (index - shift + 26) % 26
			flag += string(alphabet_lower[index])
		} else if 'A' <= char && char <= 'Z' {
			// upper case
			index = strings.IndexRune(alphabet_upper, char)

			// compensate for go not handling negative numbers with modulo
			index = (index - shift + 26) % 26
			flag += string(alphabet_upper[index])
		} else {
			// non-letter
			flag += string(char)
		}
	}
	return flag
}

func main() {
	// allocate buffer for encrypted flag
	var input = make([]byte, 100)

	// Read encrypted flag from file
	file, err := os.Open("../src/flag.txt.enc")
	if err != nil {
		fmt.Println(err)
		return
	}
	var read, _ = file.Read(input)
	defer file.Close()

	// convert to string and decrypt flag
	var ciphertext string = string(input[:read])
	var shift int = 15
	var flag string = decrypt(ciphertext, shift)
	fmt.Println(flag)
}
