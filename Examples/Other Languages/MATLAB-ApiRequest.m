% To run this script, copy and paste the code into a MATLAB script file (e.g., api_request.m) and run it in the MATLAB environment. The script will prompt you for input, send it to the API, and display the response.


% Prompt user for input
user_input = input('Enter your input: ', 's');

% Construct the API URL with the user input
api_url = ['https://endpoint.spamtec.cc/v1/tool?key=key&input=', urlencode(user_input)];

% Send the request and get the response
response = webread(api_url);

% Display the response
disp('API response:');
disp(response);
