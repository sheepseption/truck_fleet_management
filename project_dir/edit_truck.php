<?php include('includes/header.php'); ?>
<div class="container-fluid py-4">
    <div class="row min-vh-80 h-100">
        <div class="col-12">
            <div class="card shadow-lg border-0 rounded-3">
                <div class="card-header text-white" style="background-color: #0dcaf0;">
                    <h4 class="mb-0">Edit Truck Details</h4>
                </div>
                <div class="card-body">
                    <?php
                    // Include the database configuration file
                    include('dbconfig/dbconfig.php');

                    // Function to fetch truck data
                    function fetchTruck($connection, $truckId) {
                        $fetchQuery = "SELECT * FROM trucks WHERE id = ?";
                        $stmt = mysqli_prepare($connection, $fetchQuery);
                        mysqli_stmt_bind_param($stmt, 'i', $truckId);
                        mysqli_stmt_execute($stmt);
                        return mysqli_stmt_get_result($stmt);
                    }

                    // Function to update truck data
                    function updateTruck($connection, $truckId, $licensePlate, $model, $year, $capacity) {
                        $updateQuery = "UPDATE trucks SET license_plate = ?, model = ?, year = ?, capacity = ? WHERE id = ?";
                        $updateStmt = mysqli_prepare($connection, $updateQuery);
                        mysqli_stmt_bind_param($updateStmt, 'ssssi', $licensePlate, $model, $year, $capacity, $truckId);
                        return mysqli_stmt_execute($updateStmt);
                    }

                    // Check if the 'id' parameter is present in the URL
                    if (isset($_GET['id']) && !empty($_GET['id'])) {
                        $truckId = (int) $_GET['id'];
                        $result = fetchTruck($connection, $truckId);

                        if ($result && mysqli_num_rows($result) > 0) {
                            $truck = mysqli_fetch_assoc($result);
                        } else {
                            echo "<div class='alert alert-danger'>Truck not found.</div>";
                            exit;
                        }

                        // Check if the form has been submitted
                        if (isset($_POST['update_btn'])) {
                            $licensePlate = htmlspecialchars(trim($_POST['license_plate']));
                            $model = htmlspecialchars(trim($_POST['model']));
                            $year = htmlspecialchars(trim($_POST['year']));
                            $capacity = htmlspecialchars(trim($_POST['capacity']));

                            // Update the truck record in the database
                            if (updateTruck($connection, $truckId, $licensePlate, $model, $year, $capacity)) {
                                echo "<div class='alert alert-success'>Truck record updated successfully.</div>";
                            } else {
                                echo "<div class='alert alert-danger'>Error updating record: " . mysqli_error($connection) . "</div>";
                            }
                        }
                    } else {
                        echo "<div class='alert alert-danger'>Invalid truck ID.</div>";
                        exit;
                    }
                    ?>

                    <form action="" method="POST">
                        <div class="mb-3">
                            <label for="licensePlateInput" class="form-label fw-bold">License Plate</label>
                            <input type="text" class="form-control shadow-sm border-primary" id="licensePlateInput"
                                name="license_plate" value="<?php echo htmlspecialchars($truck['license_plate']); ?>"
                                required>
                        </div>
                        <div class="mb-3">
                            <label for="modelInput" class="form-label fw-bold">Model</label>
                            <input type="text" class="form-control shadow-sm border-primary" id="modelInput"
                                name="model" value="<?php echo htmlspecialchars($truck['model']); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="yearInput" class="form-label fw-bold">Year</label>
                            <input type="number" class="form-control shadow-sm border-primary" id="yearInput"
                                name="year" value="<?php echo htmlspecialchars($truck['year']); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="capacityInput" class="form-label fw-bold">Capacity (in tons)</label>
                            <input type="number" class="form-control shadow-sm border-primary" id="capacityInput"
                                name="capacity" value="<?php echo htmlspecialchars($truck['capacity']); ?>" required>
                        </div>
                        <button type="submit" name="update_btn" class="btn btn-primary">
                            <i class="bi bi-save"></i> Update
                        </button>
                        <a href="trucks_table_display.php" class="btn btn-secondary">
                            <i class="bi bi-x-circle"></i> Return
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include('includes/footer.php'); ?>