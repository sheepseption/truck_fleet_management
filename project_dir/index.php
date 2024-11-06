<?php 
include ('dbconfig/dbconfig.php');
 include('card.php'); 
include('includes/header.php'); ?>

<link href="assets/css/material-dashboard.min.css" rel="stylesheet"> <!-- Link to your custom CSS file -->
<link href="assets/css/card_statistics.css" rel="stylesheet">

<div class="container-fluid py-4">
    <div class="row min-vh-80 h-100">
        <div class="col-12">
            <div class="row">
                <div>
                    <!-- fix this "col-lg-7 position-relative z-index-2"-->
                    <div class="card card-plain mb-4">
                        <div class="card-body p-3">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="d-flex flex-column h-100">
                                        <h2 class="font-weight-bolder mb-0">Statistics</h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Statistic Cards -->

                        <div class="col-lg-5 col-md-6 col-sm-12">
                            <div class="card mb-2">
                                <div class="card-header p-3 pt-2">
                                    <div
                                        class="icon icon-lg icon-shape bg-gradient-dark shadow-dark text-center border-radius-xl mt-n4 position-absolute">
                                        <i class="material-icons opacity-10">weekend</i>
                                    </div>
                                    <div class="text-end pt-1">
                                        <p class="text-sm mb-0 text-capitalize">Bookings</p>
                                        <h4 class="mb-0">281</h4>
                                    </div>
                                </div>
                                <hr class="dark horizontal my-0">
                                <div class="card-footer p-3">
                                    <p class="mb-0"><span class="text-success text-sm font-weight-bolder">+55%
                                        </span>than last week</p>
                                </div>
                            </div>

                            <div class="card mb-2">
                                <div class="card-header p-3 pt-2">
                                    <div
                                        class="icon icon-lg icon-shape bg-gradient-primary shadow-primary text-center border-radius-xl mt-n4 position-absolute">
                                        <i class="material-icons opacity-10">leaderboard</i>
                                    </div>
                                    <div class="text-end pt-1">
                                        <p class="text-sm mb-0 text-capitalize">Today's Users</p>
                                        <h4 class="mb-0">2,300</h4>
                                    </div>
                                </div>
                                <hr class="dark horizontal my-0">
                                <div class="card-footer p-3">
                                    <p class="mb-0"><span class="text-success text-sm font-weight-bolder">+3%
                                        </span>than last month</p>
                                </div>
                            </div>
                        </div>


                        <div class="col-lg-5 col-md-6 col-sm-12 mt-sm-0 mt-4">
                            <div class="card mb-2">
                                <div class="card-header p-3 pt-2 bg-transparent">
                                    <div
                                        class="icon icon-lg icon-shape bg-gradient-success shadow-success text-center border-radius-xl mt-n4 position-absolute">
                                        <i class="material-icons opacity-10">store</i>
                                    </div>
                                    <div class="text-end pt-1">
                                        <p class="text-sm mb-0 text-capitalize">Revenue</p>
                                        <h4 class="mb-0">34k</h4>
                                    </div>
                                </div>
                                <hr class="horizontal my-0 dark">
                                <div class="card-footer p-3">
                                    <p class="mb-0"><span class="text-success text-sm font-weight-bolder">+1%
                                        </span>than yesterday</p>
                                </div>
                            </div>

                            <div class="card">
                                <div class="card-header p-3 pt-2 bg-transparent">
                                    <div
                                        class="icon icon-lg icon-shape bg-gradient-info shadow-info text-center border-radius-xl mt-n4 position-absolute">
                                        <i class="material-icons opacity-10">person_add</i>
                                    </div>
                                    <div class="text-end pt-1">
                                        <p class="text-sm mb-0 text-capitalize">Followers</p>
                                        <h4 class="mb-0">+91</h4>
                                    </div>
                                </div>
                                <hr class="horizontal my-0 dark">
                                <div class="card-footer p-3">
                                    <p class="mb-0">Just updated</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="card card-plain mb-4">
                            <div class="card-body p-3">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="d-flex flex-column h-100">
                                            <h2 class="font-weight-bolder mb-0">Overview</h2>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Additional statistics or charts can go here -->
                        <div class="container-fluid">
                            <div class="row g-4">
                                <!-- g-4 adds a gap between the columns -->
                                <div class="col-lg-6 col-md-12">
                                    <?php
            card_graphic("Today's Money", "chart1", 'bar', [53, 75, 60, 80], ['Q1', 'Q2', 'Q3', 'Q4']);
            ?>
                                </div>
                                <div class="col-lg-6 col-md-12">
                                    <?php
            card_graphic("Today's Users", "chart2", 'line', [2300, 2100, 2500, 2700], ['Mon', 'Tue', 'Wed', 'Thu']);
            ?>
                                </div>
                                <div class="col-lg-6 col-md-12">
                                    <?php
            card_graphic("Ads Views", "chart3", 'bar', [3462, 3200, 3100, 3600], ['Week 1', 'Week 2', 'Week 3', 'Week 4']);
            ?>
                                </div>
                                <div class="col-lg-6 col-md-12">
                                    <?php
            card_graphic("Sales", "chart4", 'line', [103430, 98500, 110000, 120000], ['Jan', 'Feb', 'Mar', 'Apr']);
            ?>
                                </div>
                            </div>
                        </div>




                    </div>
                </div>
            </div>




            <!-- Insert Data Card -->
            <div class="card mt-4">
                <div class="card-header text-white" style="background-color: #0dcaf0;">
                    <h4>
                        Insert Data into Database using PHP
                        <a href="insert.php" class="btn btn-light float-end">Insert Data</a>
                    </h4>
                </div>
                <div class="card-body">

                </div>
            </div>
            <!-- Fetch Data Card -->

        </div>

    </div>
</div>
</div>

<?php include('includes/footer.php'); ?>