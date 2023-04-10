# ruby ApiRequest.rb
require 'net/http'
require 'uri'

print "Enter your input: "
user_input = gets.chomp

url = URI.parse("https://endpoint.spamtec.cc/v1/tool?key=key&input=#{URI.encode_www_form_component(user_input)}")
response = Net::HTTP.get_response(url)

if response.is_a?(Net::HTTPSuccess)
  puts "API response:\n#{response.body}"
else
  puts "Error making API request: #{response.message}"
end
