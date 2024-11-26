<?php include('includes/header.php'); ?>
<div class="container-fluid py-4">
    <?php
    // Connect to the database
    include('dbconfig/dbconfig.php');

    // Initialize search query (set to empty since we're not using search filtering now)
    $searchQuery = '';

    // On détermine sur quelle page on se trouve
    if (isset($_GET['page']) && !empty($_GET['page'])) {
        $currentPage = (int) strip_tags($_GET['page']);
    } else {
        $currentPage = 1;
    }

    // On détermine le nombre total de livraisons
    $sqlCount = 'SELECT COUNT(*) AS nb_livraisons FROM livraisons;';
    $stmtCount = mysqli_prepare($connection, $sqlCount);
    mysqli_stmt_execute($stmtCount);
    $resultCount = mysqli_stmt_get_result($stmtCount);
    $rowCount = mysqli_fetch_assoc($resultCount);
    $nblivraisons = (int) $rowCount['nb_livraisons'];

    // On détermine le nombre de livraisons par page
    $parPage = 10;

    // On calcule le nombre total de pages
    $pages = ceil($nblivraisons / $parPage);

    // Calcul du premier enregistrement de la page
    $premier = ($currentPage * $parPage) - $parPage;

    // Requête pour récupérer les livraisons de la page actuelle
    $fetch_query = "SELECT * FROM livraisons ORDER BY id LIMIT ?, ?";
    $stmt = mysqli_prepare($connection, $fetch_query);
    mysqli_stmt_bind_param($stmt, 'ii', $premier, $parPage);
    mysqli_stmt_execute($stmt);
    $fetch_query_run = mysqli_stmt_get_result($stmt);
    ?>

    <div class="card mt-4">
        <div class="card-header  text-dark" style="background: linear-gradient(to right, #ff9a9e, #fecfef);">
            <h4>Livraisons Database</h4>
            <a href="index.php" class="btn btn-light float-end">
                <i class="bi bi-arrow-left-circle"></i> Return
            </a>
        </div>
        <div class="card-body">
            <!-- Search Form (not used for now, but you can reinstate it if needed) -->
            <form method="POST" class="mb-4">
                <div class="row mb-3">
                    <div class="col-md-8">
                        <div class="input-group">
                            <input type="text" class="form-control" name="search_query"
                                placeholder="Search by name or email"
                                value="<?php echo htmlspecialchars($searchQuery); ?>" aria-label="Search query"
                                style="color: #495057; background-color: #f8f9fa;">
                            <button type="submit" name="search" class="btn btn-primary">
                                <i class="bi bi-search"></i> Search
                            </button>
                        </div>
                    </div>

                </div>

            </form>

            <table class="table table-hover">
                <thead style="background-color: #4a4a4a; color: white;">
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Depot Depart</th>
                        <th scope="col">Depot Arrivee</th>
                        <th scope="col">Delivery Date</th>
                        <th scope="col">Truck ID</th>
                        <th scope="col">Driver ID</th>
                        <th scope="col">Status</th>
                        <th scope="col">Total Weight</th>
                    </tr>
                </thead>
                <tbody>
                    <?php 
                    if (mysqli_num_rows($fetch_query_run) > 0) {
                        while ($row = mysqli_fetch_assoc($fetch_query_run)) {
                    ?>
                    <tr>
                        <td><?php echo htmlspecialchars($row['id']); ?></td>
                        <td><?php echo htmlspecialchars($row['depot_depart_id']); ?></td>
                        <td><?php echo htmlspecialchars($row['depot_arrivee_id']); ?></td>
                        <td><?php echo htmlspecialchars($row['delivery_date']); ?></td>
                        <td><?php echo htmlspecialchars($row['truck_id']); ?></td>
                        <td><?php echo htmlspecialchars($row['driver_id']); ?></td>
                        <td><?php echo htmlspecialchars($row['status']); ?></td>
                        <td><?php echo htmlspecialchars($row['total_weight']); ?></td>
                    </tr>
                    <?php
                        }
                    } else {
                    ?>
                    <tr>
                        <td colspan="8">No record found</td>
                    </tr>
                    <?php
                    }
                    ?>
                </tbody>
            </table>
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item <?= ($currentPage == 1) ? "disabled" : "" ?>">
                        <a href="?page=<?= $currentPage - 1 ?>" class="page-link" aria-label="Précédente">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only"></span>
                        </a>
                    </li>
                    <?php for ($page = 1; $page <= $pages; $page++): ?>
                    <li class="page-item <?= ($currentPage == $page) ? "active" : "" ?>">
                        <a href="?page=<?= $page ?>" class="page-link"><?= $page ?></a>
                    </li>
                    <?php endfor; ?>
                    <li class="page-item <?= ($currentPage == $pages) ? "disabled" : "" ?>">
                        <a href="?page=<?= $currentPage + 1 ?>" class="page-link" aria-label="Suivante">
                            <span aria-hidden="true">&raquo;</span>
                            <span class="sr-only"></span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<?php include('includes/footer.php'); ?>