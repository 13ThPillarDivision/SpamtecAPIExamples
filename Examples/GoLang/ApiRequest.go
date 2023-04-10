// go build -o ApiRequest ApiRequest.go
package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"os"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	fmt.Print("Enter your input: ")
	userInput, _ := reader.ReadString('\n')

	apiURL := "https://endpoint.spamtec.cc/v1/tool?key=key&"
	params := url.Values{}
	params.Add("input", userInput)

	reqURL := fmt.Sprintf("%s?%s", apiURL, params.Encode())
	resp, err := http.Get(reqURL)
	if err != nil {
		fmt.Println("Error making API request:", err)
		return
	}
	defer resp.Body.Close()

	responseData, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Println("Error reading API response:", err)
		return
	}

	fmt.Println("API response:")
	fmt.Println(string(responseData))
}
