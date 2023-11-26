<?php
    session_start();
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

    function isLoggedIn($conn){
        error_log("loggedIn is called");
        $_SESSION['connection'] = $conn;

        if(isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true){
            return "true";
        } else{
            return "false";
            // die("false");
        }
    }

    function logOut(){
        unset($_SESSION['username']);
        unset($_SESSION['loggedIn']);

        // session_destroy();
        exit;
        
    }

    function logIn($feData, $conn) {
        $_SESSION['connection'] = $conn;
        $user = $feData["email"];
        $password = $feData["password"];

        $stmt = $conn->prepare("SELECT email, password FROM owner WHERE email = ? and password = ?");
        $stmt->bind_param("ss", $user, $password);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows > 0) {
            $_SESSION['username'] = $user;
            error_log("user logged in successfully");
            error_log($user);
            exit;
        } else {
            echo json_encode(['error' => 'Invalid credentials']);
        }
    }

    // connection to mysql
  	$conn = new mysqli($server, $user, $password, $db);
    // Check connection
    if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
    }

    // connect to current session information if mysql is connected

    // get input and see what FE is asking for
    $data = file_get_contents("php://input");

    $feData;
    if ($data) {
        $feData = json_decode($data, true);
        error_log("data received!");
    } else {
        json_encode(['error' => 'Invalid JSON data']);
    }

    // data received, now check what it's asking for:

    // if it's trying to login, we will login for them...
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        logIn($feData, $conn);
    }
    // if simply just checking for if session is logged in

    else {
        $testing = isLoggedIn($conn);
        error_log($testing);
        echo $testing; 
    }

?>