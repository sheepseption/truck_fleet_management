<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

session_start();

// Database connection
$connection = mysqli_connect("localhost", "sarah", "Sa.18022002", "php_tutorial");

// Checking connection success
if (!$connection) {
    die("Database connection failed: " . mysqli_connect_error());
}

// If form was submitted
if (isset($_POST["save_btn"])) {
    // Assign input data and escape for security
    $license_plate = mysqli_real_escape_string($connection, $_POST['license_plate']);
    $model = mysqli_real_escape_string($connection, $_POST['model']);
    $year = mysqli_real_escape_string($connection, $_POST['year']);
    $capacity = mysqli_real_escape_string($connection, $_POST['capacity']);

    // Check for duplicate license plate
    $license_plate_check_query = "SELECT * FROM trucks WHERE license_plate='$license_plate' LIMIT 1";
    $result = mysqli_query($connection, $license_plate_check_query);
    $existing = mysqli_fetch_assoc($result);

    if ($existing) {
        // License plate already exists
        $_SESSION['status'] = "DATA INSERT FAILED: This license plate is already registered.";
        $_SESSION['status_code'] = "error";
        header('Location: insert_truck.php');
        exit();
    } else {
        // Prepare the insert query
        $insert_query = "INSERT INTO trucks (license_plate, model, year, capacity) VALUES ('$license_plate', '$model', '$year', '$capacity')";
        
        // Execute the insert query
        if (mysqli_query($connection, $insert_query)) {
            $_SESSION['status'] = "NEW TRUCK ADDED SUCCESSFULLY";
            $_SESSION['status_code'] = "success";
            header('Location: index.php');
            exit(); // Exit to prevent further script execution
        } else {
            // Log the error message
            $_SESSION['status'] = "DATA INSERT FAILED: " . mysqli_error($connection);
            $_SESSION['status_code'] = "error";
            header('Location: insert_truck.php');
            exit(); // Exit to prevent further script execution
        }
    }
}

// Close the database connection
mysqli_close($connection);
?>