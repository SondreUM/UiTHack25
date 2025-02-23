/*
 * UiTHack25
 * rev/evasive_verify
 * author: @SondreUM
 * main.c
 */

#include <assert.h>
#include <limits.h>
#include <malloc.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Include the cURL library
// This is a library for transferring data with URLs
#include <curl/curl.h>

// Include the UUID library
// This is a library for interacting with UUIDs
// Project page: https://github.com/cloudbase/libuuid/blob/master/uuid.h
// never heard of UUIDs before? For easy introduction to uuids, see:
// https://medium.com/@gaspm/understanding-uuid-purpose-and-benefits-of-a-universal-unique-identifier-59110154d897
#include <uuid/uuid.h>

// Let the domain be visible as a string
// Since it is staticly defined, it will be visible with the strings command
// Provides hint that the program will do network communication
#define PORT 5005
#define PORT_LOCAL PORT
#define DOMAIN "uithack-2.td.org.uit.no"
#define DOMAIN_LOCAL "localhost"

#define FLAG_FORMAT "UiTHack25{"
#define KEY 0xC2

typedef enum { FALSE, TRUE } bool;

typedef struct url_data {
    size_t size;
    char *data;
} response_t;

/* util functions */

/**
 * @brief Function to validate the flag
 * @param input input string
 * @param flag correct flag string
 * @return TRUE if the flag is correct, FALSE otherwise
 */
inline static bool validate_flag(const char *input, const char *flag) {
    return strncmp(input, flag, strlen(flag)) == 0;
}

/**
 * @brief Checks that the input has correct flag format
 * @param flag input string
 * @return true if the string has correct flag format, false otherwise
 */
static bool check_flag_format(const char *flag) {
    return strncmp(flag, FLAG_FORMAT, strlen(FLAG_FORMAT)) == 0 && flag[strlen(flag) - 1] == '}';
}

/**
 * @brief Function that creates an UUID in string format
 * UUID is generated from static values (deterministic)
 * UUID: c2850b16-2c58-b061-c285-0b162c58b061
 * @param uuid buffer to store the UUID, must be at least 37 bytes long
 */
static void decode_uuid(char *str_uuid) {
    assert(str_uuid != NULL);

    uuid_t buf;
    // generate the uuid from static values
    // this will hopefully be somewhat hard,
    // but not impossible to reverse engineer
    for (int i = 0; i < (int)sizeof(uuid_t); i++) {
        buf[i] = (KEY << i) % UCHAR_MAX;
    }

    uuid_unparse_lower(buf, str_uuid);
}

/** cURL functions **/

/**
 * @brief Function to handle the response from the HTTP GET request
 * @return size_t
 */
static size_t curl_callback(void *contents, size_t size, size_t nmemb, void *userp) {
    size_t realsize = size * nmemb;
    struct url_data *mem = (struct url_data *)userp;

    char *ptr = realloc(mem->data, mem->size + realsize + 1);
    if (!ptr) {
        /* out of memory! */
        printf(
            "Out of memory! You should try downloading more RAM!\n"
            "Terminating program...\n");
        exit(EXIT_FAILURE);
    }

    mem->data = ptr;
    memcpy(&(mem->data[mem->size]), contents, realsize);
    mem->size += realsize;
    mem->data[mem->size] = 0;

    return realsize;
}

/**
 * @brief Function to perform HTTP GET requests
 * @param url URL to the remote resource
 * @param response buffer for response data
 * @return CURLcode
 */
CURLcode http_get(const char *url, response_t *response) {
    CURLcode res;
    CURL *curl_handle;

    // Initialize cURL session
    curl_handle = curl_easy_init();
    if (curl_handle) {
        // configure the cURL session
        // intentionally not using curl_multi_setopt

        // Set the URL
        curl_easy_setopt(curl_handle, CURLOPT_URL, url);
        // Set the write callback function, used to handle the response
        curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, curl_callback);
        // Set the buffer to store the response data
        curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, response);
        // Set the user agent, needed for some servers
        curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "hackerman/1.0");
        // Timeout the request after 5 seconds
        curl_easy_setopt(curl_handle, CURLOPT_TIMEOUT, 5L);

        // Perform the request
        res = curl_easy_perform(curl_handle);

        // Clean up
        curl_easy_cleanup(curl_handle);
    }

    return res;
}

// Main function to perform HTTP GET requests

/**
 * @brief Function to perform HTTP GET requests
 * @param path path to the remote resource
 * @return response data
 */
char *perform_http_get(const char *path) {
    CURLcode res;
    int buffer_size = 256;
    char local_url[buffer_size];
    char remote_url[buffer_size];

    // Construct the local and remote URLs
    snprintf(local_url, buffer_size, "http://%s:%d/%s", DOMAIN_LOCAL, PORT_LOCAL, path);
    snprintf(remote_url, buffer_size, "http://%s:%d/%s", DOMAIN, PORT, path);

    /* init the curl lib */
    curl_global_init(CURL_GLOBAL_ALL);

    // Response struct to store the response data
    response_t response = {
        .size = 0,         // returned data size
        .data = malloc(1)  // returned data buffer, will be reallocated bu curl
    };
    response.data[0] = '\0';  // ensure null-terminated string

    // Test for local connection
    // this is for testing with local docker container
    res = http_get(local_url, &response);
    if (res != CURLE_OK) {
        printf("Local connection failed. Trying remote...\n");

        // Try remote URL if local connection fails
        res = http_get(remote_url, &response);
    }

    /* we are done with libcurl, so clean it up */
    curl_global_cleanup();

    if (res == CURLE_OK) {
        return response.data;
    }
    printf(
        "Connection to verification server failed. Please try again later.\n"
        "Error: %s\n",
        curl_easy_strerror(res));
    free(response.data);
    return NULL;
}

int main(int argc, char *argv[]) {
    // ensure correct number of arguments
    if (argc < 2) {
        printf("Usage: %s <flag>\n", argv[0]);
        return EXIT_FAILURE;
    }
    // check for correct flag format
    else if (!check_flag_format(argv[1])) {
        printf(
            "Invalid flag format! No trickery allowed.\n"
            "Flag format should be: %s<flag_content>}\n"
            "10 social credits have been deducted from your account.\n",
            FLAG_FORMAT);
        return EXIT_FAILURE;
    }
    printf("Flag format is correct\n");

    char uuid[UUID_STR_LEN];
    decode_uuid(uuid);
    // printf("UUID: %s\n", uuid);
    char *remote_flag = perform_http_get(uuid);
    if (remote_flag == NULL) {
        return EXIT_FAILURE;
    }

    if (validate_flag(argv[1], remote_flag)) {
        printf("Flag is correct! You have been awarded 100 social credits.\n");
    } else {
        printf("Flag is incorrect! 10 social credits have been deducted from your account.\n");
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
