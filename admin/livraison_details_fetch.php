<?php
// Démarrage de la session
session_start();

// Connexion à la base de données
$connection = new mysqli("localhost", "sarah", "Sa.18022002", "php_tutorial");

// Vérifier la connexion
if ($connection->connect_error) {
    die("Erreur de connexion : " . $connection->connect_error);
}

// Récupération de l'ID de la livraison
$delivery_id = $_GET['delivery_id'] ?? null;

// Initialisation des variables pour les détails de la livraison
$delivery_details = [];
$products = [];
$truck_details = [];
$driver_details = [];
$departure_warehouse = [];
$arrival_warehouse = [];

if ($delivery_id) {
    // Requête pour récupérer les détails de la livraison
    $query = "
        SELECT 
            l.id AS delivery_id,
            l.delivery_date,
            l.status,
            l.total_weight,
            d1.localisation AS departure_location,
            d2.localisation AS arrival_location,
            t.license_plate AS truck_license_plate,
            t.make AS truck_make,
            t.model AS truck_model,
            dr.name AS driver_name
        FROM livraisons l
        JOIN depot d1 ON l.depot_depart_id = d1.id
        JOIN depot d2 ON l.depot_arrivee_id = d2.id
        JOIN trucks t ON l.truck_id = t.id
        JOIN drivers dr ON l.driver_id = dr.id
        WHERE l.id = ?
    ";
    $stmt = $connection->prepare($query);

    if ($stmt) {
        $stmt->bind_param("i", $delivery_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $delivery_details = $result->fetch_assoc();
        $stmt->close();
    } else {
        die("Erreur dans la requête des détails : " . $connection->error);
    }

    // Requête pour récupérer les produits associés à cette livraison
    $query = "
        SELECT 
            p.name,
            pl.quantity
        FROM produit_livraison pl
        JOIN products p ON pl.produit_id = p.id
        WHERE pl.livraison_id = ?
    ";
    $stmt = $connection->prepare($query);

    if ($stmt) {
        $stmt->bind_param("i", $delivery_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $products = $result->fetch_all(MYSQLI_ASSOC);
        $stmt->close();
    } else {
        die("Erreur dans la requête des produits : " . $connection->error);
    }
}
?>

<?php include('includes/header.php'); ?>

<div class="container py-4">
    <div class="card shadow-lg border-0 rounded-3">
        <div class="card-header text-white bg-primary">
            <h4 class="mb-0">Détails de la livraison</h4>
        </div>
        <div class="card-body">
            <?php if (!empty($delivery_details)) : ?>
            <!-- Informations générales sur la livraison -->
            <div class="mb-3">
                <h5 class="fw-bold">Informations générales :</h5>
                <p><strong>ID de la livraison :</strong> <?= htmlspecialchars($delivery_details['delivery_id']) ?></p>
                <p><strong>Date de livraison :</strong> <?= htmlspecialchars($delivery_details['delivery_date']) ?></p>
                <p><strong>Statut :</strong> <?= htmlspecialchars($delivery_details['status']) ?></p>
                <p><strong>Poids total :</strong> <?= htmlspecialchars($delivery_details['total_weight']) ?> kg</p>
                <p><strong>Dépôt de départ :</strong> <?= htmlspecialchars($delivery_details['departure_location']) ?>
                </p>
                <p><strong>Dépôt d'arrivée :</strong> <?= htmlspecialchars($delivery_details['arrival_location']) ?></p>
                <p><strong>Camion :</strong> <?= htmlspecialchars($delivery_details['truck_license_plate']) ?>
                    (<?= htmlspecialchars($delivery_details['truck_make']) ?>
                    <?= htmlspecialchars($delivery_details['truck_model']) ?>)</p>
                <p><strong>Conducteur :</strong> <?= htmlspecialchars($delivery_details['driver_name']) ?></p>
            </div>

            <!-- Liste des produits -->
            <div class="mb-3">
                <h5 class="fw-bold">Produits à livrer :</h5>
                <?php if (!empty($products)) : ?>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Produit</th>
                                <th>Quantité</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($products as $product) : ?>
                            <tr>
                                <td><?= htmlspecialchars($product['name']) ?></td>
                                <td><?= htmlspecialchars($product['quantity']) ?></td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
                <?php else : ?>
                <p class="text-muted">Aucun produit associé à cette livraison.</p>
                <?php endif; ?>
            </div>
            <?php else : ?>
            <p class="text-danger">Aucune livraison trouvée avec l'ID fourni.</p>
            <?php endif; ?>

            <!-- Bouton de retour -->
            <div class="text-end">
                <a href="index.php" class="btn btn-secondary">
                    <i class="bi bi-arrow-left-circle"></i> Retour
                </a>
            </div>
        </div>
    </div>
</div>

<?php include('includes/footer.php'); ?>