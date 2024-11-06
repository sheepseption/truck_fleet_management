<?php include('includes/header.php'); ?>
<div class="container-fluid py-4">
    <?php
    // Connect to the database
    include('dbconfig/dbconfig.php');

    // Initialize search query
    $searchQuery = '';
    if (isset($_POST['search'])) {
        $searchQuery = trim(strip_tags($_POST['search_query']));
    }

    // On détermine sur quelle page on se trouve
    if (isset($_GET['page']) && !empty($_GET['page'])) {
        $currentPage = (int) strip_tags($_GET['page']);
    } else {
        $currentPage = 1;
    }

    // On détermine le nombre total d'étudiants en fonction de la recherche
    $sqlCount = 'SELECT COUNT(*) AS nb_trucks FROM trucks WHERE make LIKE ? OR model LIKE ?;';
    $stmtCount = mysqli_prepare($connection, $sqlCount);
    $searchParam = "%" . $searchQuery . "%";
    mysqli_stmt_bind_param($stmtCount, 'ss', $searchParam, $searchParam);
    mysqli_stmt_execute($stmtCount);
    $resultCount = mysqli_stmt_get_result($stmtCount);
    $rowCount = mysqli_fetch_assoc($resultCount);
    $nbtrucks = (int) $rowCount['nb_trucks'];

    // On détermine le nombre d'étudiants par page
    $parPage = 10;

    // On calcule le nombre de pages total
    $pages = ceil($nbtrucks / $parPage);

    // Calcul du premier étudiant de la page
    $premier = ($currentPage * $parPage) - $parPage;

    // Requête pour récupérer les étudiants de la page actuelle
    $fetch_query = "SELECT * FROM trucks WHERE make LIKE ? OR model LIKE ? ORDER BY id LIMIT ?, ?;";
    $stmt = mysqli_prepare($connection, $fetch_query);
    mysqli_stmt_bind_param($stmt, 'ssii', $searchParam, $searchParam, $premier, $parPage);
    mysqli_stmt_execute($stmt);
    $fetch_query_run = mysqli_stmt_get_result($stmt);
    ?>

    <div class="card mt-4">
        <div class="card-header text-white" style="background-color: #0dcaf0;">
            <h4>Trucks database Preview</h4>
            <a href="index.php" class="btn btn-light float-end">
                <i class="bi bi-arrow-left-circle"></i> Return
            </a>
        </div>
        <div class="card-body">
            <!-- Search Form -->
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
                        <th scope="col">License Plate</th>
                        <th scope="col">Make</th>
                        <th scope="col">Model</th>
                        <th scope="col">Year</th>
                        <th scope="col">Capacity (tons)</th>
                        <th scope="col">Status</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php 
                    if (mysqli_num_rows($fetch_query_run) > 0) {
                        while ($row = mysqli_fetch_assoc($fetch_query_run)) {
                    ?>
                    <tr>
                        <td><?php echo htmlspecialchars($row['id']); ?></td>
                        <td><?php echo htmlspecialchars($row['license_plate']); ?></td>
                        <td><?php echo htmlspecialchars($row['make']); ?></td>
                        <td><?php echo htmlspecialchars($row['model']); ?></td>
                        <td><?php echo htmlspecialchars($row['year']); ?></td>
                        <td><?php echo htmlspecialchars($row['capacity']); ?></td>
                        <td><?php echo htmlspecialchars($row['status']); ?></td>
                        <td>
                            <a href="edit_truck.php?id=<?php echo $row['id']; ?>" class="btn btn-sm"
                                style="background-color: #004b6b; color: #ffffff;">
                                <i class="bi bi-pencil"></i> Edit
                            </a>
                        </td>
                    </tr>
                    <?php
                        }
                    } else {
                    ?>
                    <tr>
                        <td colspan="6">No record found</td>
                    </tr>
                    <?php
                    }
                    ?>
                </tbody>
            </table>
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item <?= ($currentPage == 1) ? "disabled" : "" ?>">
                        <a href="?page=<?= $currentPage - 1 ?>&search_query=<?= urlencode($searchQuery) ?>"
                            class="page-link" aria-label="Précédente">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only">Précédente</span>
                        </a>
                    </li>
                    <?php for ($page = 1; $page <= $pages; $page++): ?>
                    <li class="page-item <?= ($currentPage == $page) ? "active" : "" ?>">
                        <a href="?page=<?= $page ?>&search_query=<?= urlencode($searchQuery) ?>"
                            class="page-link"><?= $page ?></a>
                    </li>
                    <?php endfor; ?>
                    <li class="page-item <?= ($currentPage == $pages) ? "disabled" : "" ?>">
                        <a href="?page=<?= $currentPage + 1 ?>&search_query=<?= urlencode($searchQuery) ?>"
                            class="page-link" aria-label="Suivante">
                            <span aria-hidden="true">&raquo;</span>
                            <span class="sr-only">Suivante</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<?php include('includes/footer.php'); ?>