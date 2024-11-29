<?php include('includes/header.php'); ?>
<div class="container-fluid py-4">
    <div class="row min-vh-80 h-100">
        <div class="col-12">
            <div class="card shadow-lg border-0 rounded-3">
                <div class="card-header text-white" style="background-color: #0dcaf0;">
                    <h4 class="mb-0">
                        Edit Driver Details

                    </h4>
                </div>
                <div class="card-body">
                    <?php
                    // Include the database configuration file
                    include('dbconfig/dbconfig.php');

                    // Check if the 'id' parameter is present in the URL
                    if (isset($_GET['id']) && !empty($_GET['id'])) {
                        $driverId = (int) $_GET['id'];

                        // Fetch the driver's current data
                        $fetchQuery = "SELECT * FROM Chauffeur NATURAL JOIN Personnel WHERE Identifiant = ?";
                        $stmt = mysqli_prepare($connection, $fetchQuery);
                        mysqli_stmt_bind_param($stmt, 'i', $driverId);
                        mysqli_stmt_execute($stmt);
                        $result = mysqli_stmt_get_result($stmt);
    
                        if ($result && mysqli_num_rows($result) > 0) {
                            $driver = mysqli_fetch_assoc($result);
                        } else {
                            echo "<div class='alert alert-danger'>driver not found.</div>";
                            exit;
                        }

                        // Check if the form has been submitted
                        if (isset($_POST['update_btn'])) {
                            $id_personnel = htmlspecialchars($_POST['Identifiant']);
                            $Nom = htmlspecialchars($_POST['Nom']);
                            $Prenom = htmlspecialchars($_POST['Prenom']);
                            $adress = htmlspecialchars($_POST['Adresse']);
                            $ville_personnel = htmlspecialchars($_POST['Ville_personnel']);
                            $Anciennete = htmlspecialchars($_POST['Anciennete']);
                            $Absence = htmlspecialchars($_POST['Absence']);
                            $type_permis = htmlspecialchars($_POST['Type_permis']);


                            // Update the driver record in the database
                            $updateQuery = "UPDATE Personnel SET Nom = ?, Prenom = ?, Adresse = ?, Ville_personnel = ? WHERE id = ?";
                            $updateQuery2 = "UPDATE Chauffeur SET Type_permis = ? WHERE id = ?";
                            
                            $updateStmt = mysqli_prepare($connection, $updateQuery);
                            mysqli_stmt_bind_param($updateStmt, 'ssssi', $Nom, $Prenom, $Adress, $ville_personnel, $id_personnel);

                            if (mysqli_stmt_execute($updateStmt)) {
                                echo "<div class='alert alert-success'>Driver record updated successfully.</div>";
                            } else {
                                echo "<div class='alert alert-danger'>Error updating record: " . mysqli_error($connection) . "</div>";
                            }

                            //added
                            
                            
                            $updateStmt2 = mysqli_prepare($connection, $updateQuery2);
                            mysqli_stmt_bind_param($updateStmt, 'ssssi', $type_permis, $id_personnel);

                            if (mysqli_stmt_execute($updateStmt2)) {
                                echo "<div class='alert alert-success'>Driver record updated successfully.</div>";
                            } else {
                                echo "<div class='alert alert-danger'>Error updating record: " . mysqli_error($connection) . "</div>";
                            }
                        }
                    } else {
                        echo "<div class='alert alert-danger'>Invalid driver ID.</div>";
                        exit;
                    }
                            
                    ?>

                    <form action="" method="POST">
                        <div class="mb-3">
                            <label for="nameInput" class="form-label fw-bold">Id</label>
                            <input type="text" class="form-control shadow-sm border-primary" id="nameInput" name="name"
                                value="<?php echo $driver['Nom']; ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="nameInput" class="form-label fw-bold">Nom</label>
                            <input type="text" class="form-control shadow-sm border-primary" id="emailInput"
                                name="email" value="<?php echo $driver['Prenom']; ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="phoneInput" class="form-label fw-bold">Prenom</label>
                            <input type="tel" class="form-control shadow-sm border-primary" id="phoneInput" name="phone"
                                value="<?php echo $driver['phone']; ?>" pattern="[0-9]{10}" required>
                        </div>
                        <div class="mb-3">
                            <label for="addressInput" class="form-label fw-bold">Anciennete</label>
                            <input type="text" class="form-control shadow-sm border-primary" id="addressInput"
                                name="address" value="<?php echo $driver['address']; ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="addressInput" class="form-label fw-bold">Adresse</label>
                            <input type="text" class="form-control shadow-sm border-primary" id="addressInput"
                                name="address" value="<?php echo $driver['address']; ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="addressInput" class="form-label fw-bold">Address</label>
                            <input type="text" class="form-control shadow-sm border-primary" id="addressInput"
                                name="address" value="<?php echo $driver['address']; ?>" required>
                        </div>
                        <button type="submit" name="update_btn" class="btn btn-primary">
                            <i class="bi bi-save"></i> Update
                        </button>
                        <a href="drivers_table_display.php" class="btn btn-secondary">
                            <i class="bi bi-x-circle"></i> Return
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include('includes/footer.php'); ?>