<?php
    header('Access-Control-Allow-Origin: http://localhost:5500');

    $dotenv = parse_ini_file('.env');

    // Set environment variables
    foreach ($dotenv as $key => $value) {
    putenv("$key=$value");
    }

    $server = getenv("DB_SERVER");
    $user = getenv("DB_USERNAME");
    $password = getenv("DB_PASSWORD");
    $db = getenv("DB_DATABASE");

    // echo getenv('DB_SERVER');
    
  	$conn = new mysqli($server, $user, $password, $db);
    // Check connection
    if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
    }

    $sql = "SELECT * FROM Animal";

    // Execute the query
    $result = $conn->query($sql);

    // Check if the query was successful
    if ($result === false) {
        die("Error executing query: " . $conn->error);
    }

    $animals = array();
    while ($row = $result->fetch_assoc()) {
        $animals[] = $row;
    }

    $jsonString = json_encode($animals, JSON_PRETTY_PRINT);

    echo $jsonString;



    // Close the connection
    // $conn->close();

?>