<?php

echo "Enter your input: ";
$userInput = trim(fgets(STDIN));

$apiURL = "https://endpoint.spamtec.cc/v1/tool?key=key&input=" . urlencode($userInput);
$response = file_get_contents($apiURL);

if ($response !== false) {
    echo "API response:\n";
    echo $response;
} else {
    echo "Error making API request.";
}

?>
