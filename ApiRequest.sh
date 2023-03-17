#Replace https://endpoint.spamtec.cc/v1/tool?key=key with the desired API endpoint and adjust the query parameters as needed.
#Save the script as ApiRequest.sh and make it executable using the following command:
#chmod +x ApiRequest.sh
#./ApiRequest.sh

#!/bin/bash

read -p "Enter your input: " user_input

api_url="https://endpoint.spamtec.cc/v1/tool?key=key&"
params="input=$user_input"
full_url="$api_url?$params"

response=$(curl -s "$full_url")

echo "API response:"
echo "$response"
