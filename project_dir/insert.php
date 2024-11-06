<?php include('includes/header.php'); ?>
<div class="container-fluid py-4">
    <div class="row min-vh-80 h-100">
        <div class="col-12">
            <div class="card shadow-lg border-0 rounded-3">
                <div class="card-header  text-white">
                    <h4 class="mb-0">
                        Choose Insert Option
                        <a href="index.php" class="btn btn-light float-end">
                            <i class="bi bi-arrow-left-circle"></i> Return
                        </a>
                    </h4>
                </div>
                <div class="card-body">
                    <!-- Dropdown to choose the insertion type -->
                    <div class="mb-3">
                        <label for="insertOption" class="form-label fw-bold text-primary">Select Data Type to
                            Insert:</label>
                        <div class="input-group">
                            <span class="input-group-text bg-primary text-white border-0">
                                <i class="bi bi-file-earmark-plus"></i>
                            </span>
                            <select id="insertOption" class="form-select shadow-sm border-primary"
                                onchange="redirectToInsertPage()">
                                <option value="" selected disabled>Choose an option</option>
                                <option value="insert_driver_form.php">New Driver</option>
                                <option value="insert_truck_form.php">New Vehicle</option>
                                <option value="insert_tocomplete.php">Plan a delivery </option>
                                <option value="insert_tocomplete.php">New Wharehouse </option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// JavaScript to redirect to the selected insert page
function redirectToInsertPage() {
    var selectedOption = document.getElementById('insertOption').value;
    if (selectedOption) {
        window.location.href = selectedOption;
    }
}
</script>

<?php include('includes/footer.php'); ?>