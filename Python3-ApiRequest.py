# this script requires the requests module
# pip install requests
# Replace https://endpoint.spamtec.cc/v1/tool?key=key with the desired API endpoint.

import requests

# Get user input
user_input = input("Enter your input: ")

# Set up API URL
api_url = "https://endpoint.spamtec.cc/v1/tool?key=key&"
params = {"input": user_input}

# Send request and get response
response = requests.get(api_url, params=params)

if response.status_code == 200:
    print("API response:")
    print(response.text)
else:
    print("Request failed with status code:", response.status_code)
