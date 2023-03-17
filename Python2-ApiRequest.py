#This script uses the urllib and urllib2 modules from Python 2's standard library.
#Save the following code to a file named api_request.py:
#Replace https://endpoint.spamtec.cc/v1/tool?key=key&input with the desired API endpoint. \ v1 is the developement end point and v2 is the stable endpoint
  
import urllib
import urllib2

# Get user input
user_input = raw_input("Enter your input: ")

# Encode user input for URL
encoded_input = urllib.quote(user_input)

# Set up API URL
api_url = "https://endpoint.spamtec.cc/v1/tool?key=key&input=" + encoded_input

# Send request and get response
try:
    response = urllib2.urlopen(api_url)
    data = response.read()
    print("API response:")
    print(data)
except urllib2.HTTPError as e:
    print("Request failed with status code:", e.code)
