<?php
header('Content-Type: application/json');

$takenInput = urlencode($_GET['input'] ?? '');

if (!empty($takenInput)) {
    $url = 'https://endpoint.spamtec.cc/tool?key=key&input=' . $takenInput;
    // Replace "tool" with your desired tool & "input" with the set intake parameter for the set tool
    // Make sure to replace "key" with your actual API key
    $response = file_get_contents($url);

    if ($response === false) {
        http_response_code(500);
        echo json_encode(['error' => 'Error fetching data from external API'], flags: JSON_THROW_ON_ERROR);
    } else {
        echo $response;
    }
} else {
    http_response_code(400);
    echo json_encode(['error' => 'Input parameter is required'], flags: JSON_THROW_ON_ERROR);
}
?>
