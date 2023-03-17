#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

struct string {
  char *ptr;
  size_t len;
};

void init_string(struct string *s) {
  s->len = 0;
  s->ptr = malloc(s->len + 1);
  if (s->ptr == NULL) {
    fprintf(stderr, "malloc() failed\n");
    exit(EXIT_FAILURE);
  }
  s->ptr[0] = '\0';
}

size_t writefunc(void *ptr, size_t size, size_t nmemb, struct string *s) {
  size_t new_len = s->len + size * nmemb;
  s->ptr = realloc(s->ptr, new_len + 1);
  if (s->ptr == NULL) {
    fprintf(stderr, "realloc() failed\n");
    exit(EXIT_FAILURE);
  }
  memcpy(s->ptr + s->len, ptr, size * nmemb);
  s->ptr[new_len] = '\0';
  s->len = new_len;

  return size * nmemb;
}

int main() {
  CURL *curl;
  CURLcode res;

  char user_input[100];
  printf("Enter your input: ");
  fgets(user_input, sizeof(user_input), stdin);
  user_input[strcspn(user_input, "\n")] = 0; // Remove trailing newline

  char url[200];
  snprintf(url, sizeof(url), "https://endpoint.spamtec.cc/v1/tool?key=key&input=%s", user_input); // "v1" is the development/testing API Endpoint, "v2" is stable
  // replace the "key" with your API Key and the "input" parameter to the ncessary input for the selected tool/api
  curl_global_init(CURL_GLOBAL_DEFAULT);
  curl = curl_easy_init();
  if(curl) {
    struct string s;
    init_string(&s);

    curl_easy_setopt(curl, CURLOPT_URL, url);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writefunc);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &s);
    curl_easy_setopt(curl, CURLOPT_USERAGENT, "libcurl-agent/1.0");

    res = curl_easy_perform(curl);

    if(res != CURLE_OK) {
      fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
    } else {
      printf("API response: %s\n", s.ptr);
    }

    free(s.ptr);

    curl_easy_cleanup(curl);
  }

  curl_global_cleanup();

  return 0;
}
