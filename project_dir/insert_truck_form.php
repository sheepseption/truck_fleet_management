<?php include('includes/header.php'); ?>
<div class="container-fluid py-4">
    <div class="row min-vh-80 h-100">
        <div class="col-12">

            <div class="card">
                <div class="card-header">
                    <h4>
                        INSERT TRUCK INTO DATABASE
                        <a href="index.php" class="btn btn-danger float-end">Return</a>
                        <a href="insert_truck.php" class="btn btn-primary float-end">Refresh</a>
                    </h4>
                </div>
                <div class="card-body">
                    <form action="code_truck.php" method="POST">
                        <!-- code_truck.php is where the data gets processed when the save button is clicked -->

                        <div class="mb-3">
                            <label for="licensePlateInput" class="form-label">License Plate</label>
                            <input type="text" class="form-control" id="licensePlateInput" name="license_plate"
                                placeholder="Enter License Plate" required>
                        </div>
                        <div class="mb-3">
                            <label for="modelInput" class="form-label">Model</label>
                            <input type="text" class="form-control" id="modelInput" name="model"
                                placeholder="Enter Truck Model" required>
                        </div>
                        <div class="mb-3">
                            <label for="yearInput" class="form-label">Year</label>
                            <input type="number" class="form-control" id="yearInput" name="year"
                                placeholder="Enter Year" min="1900" max="<?php echo date('Y'); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="capacityInput" class="form-label">Capacity (in tons)</label>
                            <input type="number" class="form-control" id="capacityInput" name="capacity"
                                placeholder="Enter Capacity" required>
                        </div>
                        <button type="submit" name="save_btn" class="btn btn-primary">Save</button>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
<?php include('includes/footer.php'); ?>