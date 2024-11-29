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
    $Immatriculation = mysqli_real_escape_string($connection, $_POST['Immatriculation']);
    $num_model = mysqli_real_escape_string($connection, $_POST['Numero_modele']);
    $Date_service = mysqli_real_escape_string($connection, $_POST['Date_mise_en_service']);
    $capacity = mysqli_real_escape_string($connection, $_POST['Capacité']);
    $marque = mysqli_real_escape_string($connection, $_POST['Marque']);
    $type_vehicule = mysqli_real_escape_string($connection, $_POST['Type_vehicule']);
    $Date_achat = mysqli_real_escape_string($connection, $_POST['Date_achat']);
    $kilo = mysqli_real_escape_string($connection, $_POST['Kilometrage']);
    $Etat = mysqli_real_escape_string($connection, $_POST['Etat']);
    $kilo_vidange = mysqli_real_escape_string($connection, $_POST['Kilometrage_vidange']);
    $Localisation = mysqli_real_escape_string($connection, $_POST['Localisation']);
    $Date_controle = mysqli_real_escape_string($connection, $_POST['Date_controle_technique']);


    // Check for duplicate license plate
    $license_plate_check_query = "SELECT * FROM Camion WHERE Immatriculation='$Immatriculation' LIMIT 1";
    $result = mysqli_query($connection, $license_plate_check_query);
    $existing = mysqli_fetch_assoc($result);

    if ($existing) {
        // License plate already exists
        $_SESSION['status'] = "DATA INSERT FAILED: This license plate is already registered.";
        $_SESSION['status_code'] = "error";
        header('Location: insert_truck.php');
        exit();
    } else {
        // Prepare the insert query in Camion:
        $insert_query = "INSERT INTO Camion VALUES ('$Immatriculation', '$Date_service', '$Date_achat', '$kilo', '$Etat', '$kilo_vidange', '$Date_controle', '$Localisation', '$num_model' )";
        $insert_query_model = "INSERT INTO Modele VALUES ('$num_model', '$marque', '$type_vehicule', '$capacity')";
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
        //insert query in modele:
        if (mysqli_query($connection, $insert_query_model)) {
            $_SESSION['status'] = "NEW Model ADDED SUCCESSFULLY";
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