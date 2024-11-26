<?php include('includes/header.php'); ?>
<div class="container-fluid py-4">
    <div class="row min-vh-80 h-100">
        <div class="col-12">
            <div class="card shadow-lg border-0 rounded-3">
                <div class="card-header text-dark" style="background: linear-gradient(to right, #ff9a9e, #fecfef);">
                    <h4 class="mb-0">
                        Planifier une livraison entre dépôts
                        <a href="index.php" class="btn btn-light float-end">
                            <i class="bi bi-arrow-left-circle"></i> Retour
                        </a>
                    </h4>
                </div>
                <div class="card-body">
                    <form id="deliveryForm" method="GET" action="choisir_produits.php">
                        <!-- Champ de sélection de la date -->
                        <div class="mb-3">
                            <label for="delivery_date" class="form-label fw-bold text-primary">Date de livraison
                                :</label>
                            <input type="date" id="delivery_date" name="delivery_date" class="form-control" required>
                        </div>
                        <!-- Dropdown to choose departure warehouse -->
                        <div class="mb-3">
                            <label for="departure" class="form-label fw-bold text-primary">Entrez le dépot de
                                départ:</label>
                            <div class="input-group">
                                <span class="input-group-text bg-primary text-white border-0">
                                    <i class="bi bi-box"></i>
                                </span>
                                <select id="departure" name="departure" class="form-select shadow-sm border-primary"
                                    required>
                                    <option value="" selected disabled>Choisissez un dépôt</option>
                                    <?php
                                    // Connect to the database
                                    session_start();

// connection
$conn = mysqli_connect("localhost", "sarah", "Sa.18022002", "php_tutorial");
                                    // Fetch warehouses
                                    $query = "SELECT id, nom FROM depot";
                                    $result = mysqli_query($conn, $query);

                                    // Check if the query succeeded
                                    if (!$result) {
                                        echo '<option disabled>Erreur SQL : ' . htmlspecialchars(mysqli_error($conn)) . '</option>';
                                    } else {
                                        // Populate dropdown
                                        while ($row = mysqli_fetch_assoc($result)) {
                                            echo '<option value="' . htmlspecialchars($row['id']) . '">' . htmlspecialchars($row['nom']) . '</option>';
                                        }
                                    }

                                    // Free result and close connection
                                    mysqli_free_result($result);
                                    mysqli_close($conn);
                                    ?>
                                </select>
                            </div>
                        </div>

                        <!-- Dropdown to choose arrival warehouse -->
                        <div class="mb-3">
                            <label for="arrival" class="form-label fw-bold text-primary">Entrez le dépot
                                d'arrivée:</label>
                            <div class="input-group">
                                <span class="input-group-text bg-primary text-white border-0">
                                    <i class="bi bi-building"></i>
                                </span>
                                <select id="arrival" name="arrival" class="form-select shadow-sm border-primary"
                                    required>
                                    <option value="" selected disabled>Choisissez un dépôt</option>
                                    <?php
                                    // Reconnect to the database (as we closed it earlier)
                                       session_start();

// connection
$conn = mysqli_connect("localhost", "sarah", "Sa.18022002", "php_tutorial");

                                    $query = "SELECT id, nom FROM depot";
                                    $result = mysqli_query($conn, $query);

                                    if (!$result) {
                                        echo '<option disabled>Erreur SQL : ' . htmlspecialchars(mysqli_error($conn)) . '</option>';
                                    } else {
                                        while ($row = mysqli_fetch_assoc($result)) {
                                            echo '<option value="' . htmlspecialchars($row['id']) . '">' . htmlspecialchars($row['nom']) . '</option>';
                                        }
                                    }

                                    mysqli_free_result($result);
                                    mysqli_close($conn);
                                    ?>
                                </select>
                            </div>
                        </div>

                        <!-- Save button -->
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary shadow-sm">
                                <i class="bi bi-check-circle"></i> Sauvegarder
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<?php include('includes/footer.php'); ?>