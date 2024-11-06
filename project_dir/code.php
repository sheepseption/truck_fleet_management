<?php
//  debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);


session_start();

// connection
$connection = mysqli_connect("localhost", "sarah", "Sa.18022002", "php_tutorial");

// Checking  connection success
if (!$connection) {
    die("Database connection failed: " . mysqli_connect_error());
}

// if form was submitted
if (isset($_POST["save_btn"])) {
    // we will assign input data
    $name = mysqli_real_escape_string($connection, $_POST['name']);
    $email = mysqli_real_escape_string($connection, $_POST['email']);
    $phone = mysqli_real_escape_string($connection, $_POST['phone']);
    $address = mysqli_real_escape_string($connection, $_POST['address']);

    // duplicate query
    $email_check_query = "SELECT * FROM drivers WHERE email='$email' LIMIT 1";
    $result = mysqli_query($connection, $email_check_query);
    $existing_user = mysqli_fetch_assoc($result);
    $other_conditions=true;
    if ($existing_user) {
        // Email already exists
        $_SESSION['status'] = "DATA INSERT FAILED: This email is already registered.";
        $other_conditions=false; // error message
        header('Location: insert.php');
        exit();
    } else {
        // Prepare the insert query
        $insert_query = "INSERT INTO drivers (name, email, phone, address) VALUES ('$name', '$email', '$phone', '$address')";

        // Execute the insert query
        $insert_query_run = mysqli_query($connection, $insert_query);

        // Check if the insertion was successful
        if ($insert_query_run && $other_conditions) {
            $_SESSION['status'] = "DATA INSERTED SUCCESSFULLY";
            $_SESSION['status_code']="success";
            header('Location: index.php');
            exit(); // Exit to prevent further script execution
        } else {
            // Log the error message
            $error_message = mysqli_error($connection);
            $_SESSION['status'] = "DATA INSERT FAILED: " . $error_message;
            $_SESSION['status_code'] = "error";
            header('Location: insert.php');
            exit(); // Exit to prevent further script execution
        }
    }
}

// Close the database connection
mysqli_close($connection);
?>