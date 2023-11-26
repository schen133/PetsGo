<?php
    header('Access-Control-Allow-Origin: http://localhost:5500');
    header('Content-Type: application/json');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE');
    header('Access-Control-Allow-Headers: Content-Type');


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

    $data = file_get_contents("php://input");

    // print($animalData);

    // if (empty($animalData)) {
    //     die("No data received from the frontend.");

    // }

    $animalData;

    if ($data) {
        $animalData = json_decode($data, true);
    
        error_log("we got them information!!");
        

        
 
    } else {
        // Handle the case where $animalData is not valid JSON
        json_encode(['error' => 'Invalid JSON data']);

    }    

    

// print($animalData);

    $sql = "DELETE FROM Animal where animal_ID = ?";

    // Use prepared statement to prevent SQL injection
    $stmt = $conn->prepare($sql);

    if ($stmt) {
        // Bind parameters
        $stmt->bind_param("i", $animalData);  // Assuming 'i' is the data type of your ID (integer)

        // Execute the statement
        $stmt->execute();

        // Check for success
        if ($stmt->affected_rows > 0) {
            echo "Animal data deleted successfully!";
        } else {
            echo "Error deleting animal: " . $stmt->error;
        }

        // Close the statement
        $stmt->close();
    } else {
        echo "Error preparing statement: " . $conn->error;
    }

    // Close the connection
    // $conn->close();

?>