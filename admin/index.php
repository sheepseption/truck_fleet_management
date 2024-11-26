<?php 
include('includes/header.php'); 
?>

<link href="assets/css/material-dashboard.min.css" rel="stylesheet">
<link href="assets/css/card_statistics.css" rel="stylesheet">

<div class="container-fluid py-4">
    <div class="row min-vh-80 h-100">
        <div class="col-12">
            <!-- Page Header -->
            <div class="row">
                <div>
                    <div class="card card-plain mb-4">
                        <div class="card-body p-3">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="d-flex flex-column h-100">
                                        <h2 class="font-weight-bolder mb-0">Statistiques</h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="row">
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="card mb-2">
                                <div class="card-header p-3 pt-2">
                                    <div
                                        class="icon icon-lg icon-shape bg-gradient-dark shadow-dark text-center border-radius-xl mt-n4 position-absolute">
                                        <i class="material-icons opacity-10">local_shipping</i>
                                    </div>
                                    <div class="text-end pt-1">
                                        <p class="text-sm mb-0 text-capitalize">Total Deliveries</p>
                                        <h4 class="mb-0">120</h4>
                                    </div>
                                </div>
                                <hr class="dark horizontal my-0">
                                <div class="card-footer p-3">
                                    <p class="mb-0"><span class="text-success text-sm font-weight-bolder">+10%</span>
                                        than last month</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="card mb-2">
                                <div class="card-header p-3 pt-2">
                                    <div
                                        class="icon icon-lg icon-shape bg-gradient-primary shadow-primary text-center border-radius-xl mt-n4 position-absolute">
                                        <i class="material-icons opacity-10">directions_car</i>
                                    </div>
                                    <div class="text-end pt-1">
                                        <p class="text-sm mb-0 text-capitalize">Active Trucks</p>
                                        <h4 class="mb-0">45</h4>
                                    </div>
                                </div>
                                <hr class="dark horizontal my-0">
                                <div class="card-footer p-3">
                                    <p class="mb-0"><span class="text-success text-sm font-weight-bolder">+5%</span>
                                        than last week</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="card mb-2">
                                <div class="card-header p-3 pt-2">
                                    <div
                                        class="icon icon-lg icon-shape bg-gradient-success shadow-success text-center border-radius-xl mt-n4 position-absolute">
                                        <i class="material-icons opacity-10">person</i>
                                    </div>
                                    <div class="text-end pt-1">
                                        <p class="text-sm mb-0 text-capitalize">Registered Drivers</p>
                                        <h4 class="mb-0">35</h4>
                                    </div>
                                </div>
                                <hr class="dark horizontal my-0">
                                <div class="card-footer p-3">
                                    <p class="mb-0">Updated recently</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Additional Statistics Cards -->
                    <div class="row">
                        <!-- Average Weight Transported Per Truck Per Delivery -->
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="card mb-2">
                                <div class="card-header p-3 pt-2">
                                    <div
                                        class="icon icon-lg icon-shape bg-gradient-info shadow-info text-center border-radius-xl mt-n4 position-absolute">
                                        <i class="material-icons opacity-10">scale</i>
                                    </div>
                                    <div class="text-end pt-1">
                                        <p class="text-sm mb-0 text-capitalize">Avg Weight/Delivery</p>
                                        <h4 class="mb-0">750 kg</h4>
                                    </div>
                                </div>
                                <hr class="dark horizontal my-0">
                                <div class="card-footer p-3">
                                    <p class="mb-0">Data based on recent deliveries</p>
                                </div>
                            </div>
                        </div>

                        <!-- Average Distance Per Delivery -->
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="card mb-2">
                                <div class="card-header p-3 pt-2">
                                    <div
                                        class="icon icon-lg icon-shape bg-gradient-warning shadow-warning text-center border-radius-xl mt-n4 position-absolute">
                                        <i class="material-icons opacity-10">map</i>
                                    </div>
                                    <div class="text-end pt-1">
                                        <p class="text-sm mb-0 text-capitalize">Avg Distance/Delivery</p>
                                        <h4 class="mb-0">120 km</h4>
                                    </div>
                                </div>
                                <hr class="dark horizontal my-0">
                                <div class="card-footer p-3">
                                    <p class="mb-0">Updated weekly</p>
                                </div>
                            </div>
                        </div>

                        <!-- Top Driver -->
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="card mb-2">
                                <div class="card-header p-3 pt-2">
                                    <div
                                        class="icon icon-lg icon-shape bg-gradient-success shadow-success text-center border-radius-xl mt-n4 position-absolute">
                                        <i class="material-icons opacity-10">emoji_events</i>
                                    </div>
                                    <div class="text-end pt-1">
                                        <p class="text-sm mb-0 text-capitalize">Top Driver</p>
                                        <h4 class="mb-0">John Doe</h4>
                                    </div>
                                </div>
                                <hr class="dark horizontal my-0">
                                <div class="card-footer p-3">
                                    <p class="mb-0">Most deliveries completed this month</p>
                                </div>
                            </div>
                        </div>


                    </div>

                    <!-- Overview Section -->
                    <div>
                        <div class="card card-plain mb-4">
                            <div class="card-body p-3">
                                <div class="row">
                                    <div class="col-lg-6">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Additional Statistics -->
                        <div class="container-fluid">
                            <div class="row g-4">
                                <div class="col-lg-6 col-md-12">
                                    <div class="card mb-4">
                                        <div class="card-body">
                                            <h6>Monthly Deliveries</h6>
                                            <canvas id="chart1"></canvas>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-12">
                                    <div class="card mb-4">
                                        <div class="card-body">
                                            <h6>Truck Utilization</h6>
                                            <canvas id="chart2"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6 col-md-12">
                                    <div class="card mb-4">
                                        <div class="card-body">
                                            <h6>Driver Rankings</h6>
                                            <div class="table-responsive">
                                                <table class="table align-items-center mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th
                                                                class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                                Rank</th>
                                                            <th
                                                                class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                                                                Driver Name</th>
                                                            <th
                                                                class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                                                                Deliveries</th>
                                                            <th
                                                                class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                                                                Distance (km)</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <!-- Static Driver Data -->
                                                        <tr>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">1</p>
                                                            </td>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">John Doe</p>
                                                            </td>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">35</p>
                                                            </td>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">1,200</p>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">2</p>
                                                            </td>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">Jane Smith</p>
                                                            </td>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">28</p>
                                                            </td>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">950</p>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">3</p>
                                                            </td>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">Robert Brown
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">22</p>
                                                            </td>
                                                            <td>
                                                                <p class="text-xs font-weight-bold mb-0">800</p>
                                                            </td>
                                                        </tr>
                                                        <!-- Add more rows as needed -->
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Another Chart or Component if Needed -->
                                <div class="col-lg-6 col-md-12">
                                    <div class="card mb-4">
                                        <div class="card-body">
                                            <h6>Other Overview Stats</h6>
                                            <!-- Placeholder for other stats or charts -->
                                            <p>Add another chart or custom data visualization here.</p>
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
                                Insert Data into Database
                                <a href="insert.php" class="btn btn-light float-end">Insert Data</a>
                            </h4>
                        </div>
                        <div class="card-body">
                            <p class="mb-0">Use this section to insert new trucks, drivers, or delivery records.</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
// Static Chart Data
const ctx1 = document.getElementById('chart1').getContext('2d');
new Chart(ctx1, {
    type: 'bar',
    data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr'],
        datasets: [{
            label: 'Deliveries',
            data: [100, 120, 150, 180],
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true
    }
});

const ctx2 = document.getElementById('chart2').getContext('2d');
new Chart(ctx2, {
    type: 'line',
    data: {
        labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
        datasets: [{
            label: 'Utilization',
            data: [75, 80, 85, 90],
            backgroundColor: 'rgba(153, 102, 255, 0.2)',
            borderColor: 'rgba(153, 102, 255, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true
    }
});
</script>

<?php include('includes/footer.php'); ?>