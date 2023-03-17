/*
npm install axios @types/readline
tsc ApiRequest.ts
node ApiRequest.js
*/
import axios from 'axios';
import * as readline from 'readline';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Enter your input: ', async (userInput: string) => {
  try {
    const response = await axios.get(`https://endpoint.spamtec.cc/v1/tool?key=key&input=${encodeURIComponent(userInput)}`);
    console.log('API response:', response.data);
  } catch (error) {
    console.error('Error making API request:', error.message);
  } finally {
    rl.close();
  }
});
