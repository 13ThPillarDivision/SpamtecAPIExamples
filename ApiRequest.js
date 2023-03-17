// This example uses the axios library for making HTTP requests. You can install it using npm: npm install axios
// Replace https://endpoint.spamtec.cc/v1/tool?key=key& with the desired API endpoint.


const axios = require('axios');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

// Get user input
rl.question('Enter your input: ', async (userInput) => {
  // Set up API URL
  const apiUrl = 'https://endpoint.spamtec.cc/v1/tool?key=key&';
  const params = `input=${encodeURIComponent(userInput)}`;
  const fullUrl = `${apiUrl}?${params}`;

  try {
    // Send request and get response
    const response = await axios.get(fullUrl);

    console.log('API response:');
    console.log(response.data);
  } catch (error) {
    console.error(`Request failed with status code: ${error.response.status}`);
  }

  rl.close();
});
