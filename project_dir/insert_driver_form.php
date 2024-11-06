<?php include('includes/header.php'); ?>
<div class="container-fluid py-4">
    <div class="row min-vh-80 h-100">
        <div class="col-12">

            <div class="card">
                <div class="card-header">
                    <h4>
                        INSERT INTO DATABASE
                        <a href="index.php" class="btn btn-danger float-end">Return</a>
                        <a href="insert.php" class="btn btn-primary float-end">Refresh</a>
                    </h4>
                </div>
                <div class="card-body">
                    <form action="code.php" method="POST">
                        <!--code.php is what goes to execution  when the the save 
                        button is clicked-->

                        <div class="mb-3">
                            <label for="nameInput">Name</label>
                            <input type="text" class="form-control" id="nameInput" name="name" placeholder="Enter Name"
                                required>
                        </div>
                        <div class="mb-3">
                            <label for="emailInput">Email Address</label>
                            <input type="email" class="form-control" id="emailInput" name="email"
                                placeholder="Enter Email" required>
                        </div>
                        <div class="mb-3">
                            <label for="phoneInput">Phone Number</label>
                            <input type="tel" class="form-control" id="phoneInput" name="phone"
                                placeholder="Enter Phone Number" pattern="[0-9]{10}"
                                title="Please enter a 10-digit phone number" required>
                        </div>
                        <div class="mb-3">
                            <label for="addressInput">Address</label>
                            <input type="text" class="form-control" id="addressInput" name="address"
                                placeholder="Enter Address" required>
                        </div>
                        <button type="submit" name="save_btn" class="btn btn-primary">Save</button>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
<?php include('includes/footer.php'); ?>