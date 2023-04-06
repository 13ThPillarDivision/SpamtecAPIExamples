<?php
header('Content-Type: application/json');

if (isset($_GET['input'])) {
    $takenInput = intval($_GET['input']);

    if ($postId > 0) {
        $url = 'https://endpoint.spamtec.cc/tool?key=key&input=' . $takenInput; // Replace "tool" With your desired tool & "input" with the set intake paremeter for set tool
        $response = file_get_contents($url);

        if ($response === false) {
            http_response_code(500);
            echo json_encode(['error' => 'Error fetching data from external API']);
        } else {
            echo $response;
        }
    } else {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid input provided']);
    }
} else {
    http_response_code(400);
    echo json_encode(['error' => 'input parameter is required']);
}
?>
