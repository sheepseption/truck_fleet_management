<?php
// Démarrage de la session
session_start();

// Connexion à la base de données avec mysqli
$connection = new mysqli("localhost", "sarah", "Sa.18022002", "php_tutorial");

// Vérifier si la connexion a échoué
if ($connection->connect_error) {
    die("Erreur de connexion : " . $connection->connect_error);
}

// Récupération des entrepôts de départ et d'arrivée depuis les paramètres GET
$departure = $_GET['departure'] ?? null;
$arrival = $_GET['arrival'] ?? null;
$delivery_date=$_GET['delivery_date'] ?? null;

// Initialisation des produits
$products = [];
if ($departure) {
    // Requête pour récupérer les produits du dépôt de départ
    $query = "SELECT id, name, quantity FROM products WHERE warehouse_id = ?";
    $stmt = $connection->prepare($query);

    if ($stmt) {
        $stmt->bind_param("i", $departure);
        $stmt->execute();
        $result = $stmt->get_result();
        $products = $result->fetch_all(MYSQLI_ASSOC);
        $stmt->close();
    } else {
        die("Erreur dans la requête : " . $connection->error);
    }
}
?>
<?php include('includes/header.php'); ?>
<div class="container-fluid py-4">
    <div class="row min-vh-80 h-100">
        <div class="col-12">
            <div class="card shadow-lg border-0 rounded-3">
                <div class="card-header text-dark" style="background: linear-gradient(to right, #ff9a9e, #fecfef);">
                    <h4 class="mb-0">
                        Sélection des produits à envoyer depuis le dépôt n°(<?= $departure ?>) vers le dépôt
                        n°(<?= $arrival ?>)
                        <a href="index.php" class="btn btn-light float-end">
                            <i class="bi bi-arrow-left-circle"></i> Retour
                        </a>
                    </h4>
                </div>
                <div class="card-body">
                    <!-- Formulaire de sélection des produits et quantités -->
                    <form method="POST" action="process_delivery.php">

                        <!-- Champs cachés pour les dépôts et pour la date qui ont été récupérés 
                         précedemment -->
                        <input type="hidden" name="departure" value="<?php echo htmlspecialchars($departure); ?>">
                        <input type="hidden" name="arrival" value="<?php echo htmlspecialchars($arrival); ?>">
                        <input type="hidden" name="delivery_date"
                            value="<?php echo htmlspecialchars($delivery_date); ?>">
                        <div class="mb-3">
                            <label class="form-label fw-bold text-primary">Produits à envoyer :</label>
                            <!-- Liste dynamique des produits -->
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Produit</th>
                                            <th>Quantité disponible</th>
                                            <th>Quantité à envoyer</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php if (!empty($products)) : ?>
                                        <?php foreach ($products as $product) : ?>
                                        <tr>
                                            <td><?php echo htmlspecialchars($product['name']); ?></td>
                                            <td><?php echo htmlspecialchars($product['quantity']); ?></td>
                                            <td>
                                                <input type="number" name="products[<?php echo $product['id']; ?>]"
                                                    class="form-control" min="0"
                                                    max="<?php echo htmlspecialchars($product['quantity']); ?>"
                                                    placeholder="0">
                                            </td>
                                        </tr>
                                        <?php endforeach; ?>
                                        <?php else : ?>
                                        <tr>
                                            <td colspan="3" class="text-center text-muted">Aucun produit disponible dans
                                                ce dépôt.</td>
                                        </tr>
                                        <?php endif; ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Bouton Sauvegarder -->
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary shadow-sm">
                                <i class="bi bi-check-circle"></i> Confirmer
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<?php include('includes/footer.php'); ?>