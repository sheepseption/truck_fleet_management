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
    $id_personnel = mysqli_real_escape_string($connection, $_POST['Identifiant']);
    $nom = mysqli_real_escape_string($connection, $_POST['Nom']);
    $prenom = mysqli_real_escape_string($connection, $_POST['Prenom']);
    $adresse = mysqli_real_escape_string($connection, $_POST['Adresse']);
    $ville_personnel = mysqli_real_escape_string($connection, $_POST['Ville_personnel']);
    $Anciennete = mysqli_real_escape_string($connection, $_POST['Anciennete']);
    $Absence = mysqli_real_escape_string($connection, $_POST['Absence']);
    $type_permis = mysqli_real_escape_string($connection, $_POST['Type_permis']);


    // duplicate query
    $id_check_query = "SELECT * FROM Chauffeur WHERE Identifiant ='$id_personnel' LIMIT 1";
    $result = mysqli_query($connection, $id_check_query);
    $existing_user = mysqli_fetch_assoc($result);
    $other_conditions=true;
    if ($existing_user) {
        // Email already exists
        $_SESSION['status'] = "DATA INSERT FAILED: This id is already registered.";
        $other_conditions=false; // error message
        header('Location: insert.php');
        exit();
    } else {
        // Prepare the insert query personnel
        $insert_query_personnel = "INSERT INTO Personnel VALUES ('$id_personnel', '$nom', '$prenom', '$adresse', '$ville_personnel', '$Anciennete', '$Absence')";
        // Execute the insert query
        $insert_query_run_perso = mysqli_query($connection, $insert_query_personnel);

        // Check if the insertion was successful
        if ($insert_query_run_perso && $other_conditions) {
            $_SESSION['status'] = "DATA INSERTED SUCCESSFULLY";
            $_SESSION['status_code']="success";
            header('Location: index.php');
            exit(); // Exit to prevent further script execution
        } else {
            // Log the error message
            $error_message = mysqli_error($connection);
            $_SESSION['status'] = "DATA PERSO INSERT FAILED: " . $error_message;
            $_SESSION['status_code'] = "error";
            header('Location: insert.php');
            exit(); // Exit to prevent further script execution
        }

        // Prepare the insert query chauffeur
        $insert_query = "INSERT INTO Chauffeur VALUES ('$id_personnel', '$type_permis')";

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