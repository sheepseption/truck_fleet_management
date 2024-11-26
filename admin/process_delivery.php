<?php
// Enable error reporting for debugging
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Start the session at the top of the file
session_start();

// Include header
include('includes/header.php'); 
?>

<div class="container-fluid py-4">
    <?php
    // Connexion au serveur mysqli
    $connection = new mysqli("localhost", "sarah", "Sa.18022002", "php_tutorial");

    // Vérifier la connexion
    if ($connection->connect_error) {
        die("Erreur de connexion : " . $connection->connect_error);
    } else {
        echo "Connexion réussie.<br>";  // Debugging connection
    }

    // Vérifier si le formulaire a été soumis et si des produits ont été sélectionnés
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Debugging POST data
        echo '<pre>';
        print_r($_POST);
        echo '</pre>';

        if (isset($_POST['products'])) {
            // Récupérer les produits sélectionnés et leur quantité
            $selected_products = $_POST['products'];
            $departure = $_POST['departure'];  // Récupérer l'entrepôt de départ
            $arrival = $_POST['arrival'];      // Récupérer l'entrepôt d'arrivée
            $delivery_date = isset($_POST['delivery_date']) ? $_POST['delivery_date'] : null;  // Récupérer la date de livraison

            // Check if delivery_date exists and is valid
            if (empty($delivery_date)) {
                die("Erreur : La date de livraison est obligatoire.");
            }

            // Validation des données
            if (empty($departure) || empty($arrival)) {
                die("Erreur : Les dépôts de départ et d'arrivée sont obligatoires.");
            }

            if ($departure == $arrival) {
                die("Erreur : Les dépôts de départ et d'arrivée ne peuvent pas être identiques.");
            }

            // Validation de la date de livraison
            if (strtotime($delivery_date) <time()) {
                die("Erreur : La date de livraison doit être supérieure à la date courante.");
            }

            // Calculer le poids total des produits sélectionnés
            $total_weight = 0;
            foreach ($selected_products as $product_id => $quantity) {
                // Supposer que chaque produit a un poids par défaut de 1 pour l'exemple, tu peux ajuster selon tes besoins
                $total_weight += $quantity;  // Calculer le poids total
            }

            // Vérifier que la quantité totale est supérieure à la quantité minimale
            $min_weight = 10;  // Poids minimal exemple
            if ($total_weight < $min_weight) {
                die("Erreur : La quantité minimale de produits n'est pas atteinte.");
            }

            // Debugging total weight
            echo "Poids total des produits : " . $total_weight . "<br>";

            // Trouver le couple camion et chauffeur disponibles pour la livraison
            $truck_id = get_available_truck($total_weight);
            $driver_id = get_available_driver();

            if (!$truck_id || !$driver_id) {
                die("Erreur : Aucun camion ou chauffeur disponible.");
            }

            // Debugging truck and driver
            echo "Camion ID : " . $truck_id . "<br>";
            echo "Chauffeur ID : " . $driver_id . "<br>";

            // Créer la livraison dans la base de données
            $delivery_id = create_delivery($truck_id, $driver_id, $delivery_date, $departure, $arrival, $total_weight);

            // Insérer les produits associés à la livraison
            foreach ($selected_products as $product_id => $quantity) {
                insert_product_delivery($delivery_id, $product_id, $quantity);
            }

            echo "Livraison programmée avec succès!<br>";
        } else {
            echo "Aucun produit sélectionné.<br>";
        }
    }

    // Fonction pour récupérer un camion disponible
    function get_available_truck($required_capacity) {
        global $connection;

        // Requête pour trouver un camion avec la capacité suffisante
        $query = "SELECT id FROM trucks WHERE capacity >= ?  LIMIT 1";
        $stmt = $connection->prepare($query);
        $stmt->bind_param("i", $required_capacity);
        if (!$stmt->execute()) {
            die("Erreur lors de l'exécution de la requête pour le camion : " . $stmt->error);
        }
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        return $row ? $row['id'] : null;
    }

    // Fonction pour récupérer un chauffeur disponible
    function get_available_driver() {
        global $connection;

        // Requête pour trouver un chauffeur disponible
        $query = "SELECT id FROM drivers  LIMIT 1";
        $stmt = $connection->prepare($query);
        if (!$stmt->execute()) {
            die("Erreur lors de l'exécution de la requête pour le chauffeur : " . $stmt->error);
        }
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        return $row ? $row['id'] : null;
    }

    // Fonction pour créer une livraison dans la base de données
    function create_delivery($truck_id, $driver_id, $delivery_date, $departure, $arrival, $total_weight) {
        global $connection;

        // Insérer la livraison dans la table des livraisons
        $query = "INSERT INTO livraisons (truck_id, driver_id, delivery_date, depot_depart_id, depot_arrivee_id, status, total_weight) 
                  VALUES (?, ?, ?, ?, ?, 'scheduled', ?)";
        $stmt = $connection->prepare($query);
        $stmt->bind_param("iisssi", $truck_id, $driver_id, $delivery_date, $departure, $arrival, $total_weight);
        if (!$stmt->execute()) {
            die("Erreur lors de la création de la livraison : " . $stmt->error);
        }

        return $connection->insert_id;  // Retourner l'ID de la livraison créée
    }

    // Fonction pour insérer les correspondances produit-livraison
    function insert_product_delivery($delivery_id, $product_id, $quantity) {
        global $connection;

        // Insérer la correspondance produit-livraison dans la table
        $query = "INSERT INTO produit_livraison (livraison_id, produit_id, quantity) VALUES (?, ?, ?)";
        $stmt = $connection->prepare($query);
        $stmt->bind_param("iii", $delivery_id, $product_id, $quantity);
        if (!$stmt->execute()) {
            die("Erreur lors de l'insertion des produits pour la livraison : " . $stmt->error);
        }
    }
    ?>
</div>

<?php 
// Include footer
include('includes/footer.php'); 
?>