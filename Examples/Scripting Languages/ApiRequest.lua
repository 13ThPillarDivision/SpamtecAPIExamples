-- Install LuaSocket if you haven't already: For example, using LuaRocks, you can use luarocks install luasocket.
-- Save the following code to a file named ApiRequest.lua
-- Replace https://api.spamtec.cc/v1/tool?key=key&input= with the desired API Tool/endpoint configuration.
-- Run the script using the Lua interpreter: lua ApiRequest.lua.
-- The script will prompt you for input, send it to the API, and display the response.*/
  
local http = require("socket.http")
local url = require("socket.url")

-- Get user input
print("Enter your input:")
local user_input = io.read()

-- Encode user input for URL
local encoded_input = url.escape(user_input)

-- Set up API URL
local api_url = "https://api.spamtec.cc/tool?input=" .. encoded_input

-- Send request and get response
local response, status_code = http.request(api_url)

-- Check if request was successful
if status_code == 200 then
    print("API response:")
    print(response)
else
    print("Request failed with status code:", status_code)
end
