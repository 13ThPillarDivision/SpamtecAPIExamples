/*
First, you need to install libcurl. On Ubuntu or Debian, you can install it with: apt-get install libcurl4-openssl-dev
For other platforms, you can follow the instructions on the official libcurl website: https://curl.se/libcurl/
After installing the library, save the following code to a file named ApiRequest.cpp:
Replace https://endpoint.spamtec.cc/v1/tool?key=key& with the desired API endpoint.

To compile and run the script, use the following commands: g++ ApiRequest.cpp -o ApiRequest -lcurl
./ApiRequest
*/
#include <iostream>
#include <string>
#include <curl/curl.h>

size_t WriteCallback(void* contents, size_t size, size_t nmemb, void* userp)
{
    ((std::string*)userp)->append((char*)contents, size * nmemb);
    return size * nmemb;
}

int main()
{
    std::string userInput;
    std::cout << "Enter your input: ";
    std::getline(std::cin, userInput);

    CURL* curl;
    CURLcode res;
    std::string readBuffer;

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if(curl) {
        std::string apiUrl = "https://endpoint.spamtec.cc/v1/tool?key=key&";
        std::string params = "input=" + userInput;
        std::string fullUrl = apiUrl + "?" + params;

        curl_easy_setopt(curl, CURLOPT_URL, fullUrl.c_str());
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &readBuffer);

        res = curl_easy_perform(curl);

        if(res != CURLE_OK)
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));

        curl_easy_cleanup(curl);
    }

    curl_global_cleanup();

    std::cout << "API response:" << std::endl;
    std::cout << readBuffer << std::endl;

    return 0;
}
