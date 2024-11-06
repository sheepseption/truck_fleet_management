<aside
    class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3 bg-gradient-dark"
    id="sidenav-main">
    <div class="sidenav-header">
        <i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
            aria-hidden="true" id="iconSidenav"></i>
        <a class="navbar-brand m-0" href="#" target="_blank">
            <span class="ms-1 font-weight-bold text-white">Logistics Management System</span>
        </a>
    </div>
    <hr class="horizontal light mt-0 mb-2">
    <div class="collapse navbar-collapse w-auto max-height-vh-100" id="sidenav-collapse-main">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link text-white <?php echo ($current_page == 'index.php') ? 'active' : ''; ?>"
                    href="index.php"
                    style="<?php echo ($current_page == 'index.php') ? 'background-color: #0dcaf0;' : ''; ?>">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">dashboard</i>
                    </div>
                    <span class="nav-link-text ms-1">Home</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white <?php echo ($current_page == 'insert.php') ? 'active' : ''; ?>"
                    href="insert.php"
                    style="<?php echo ($current_page == 'insert.php') ? 'background-color: #0dcaf0;' : ''; ?>">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">table_view</i>
                    </div>
                    <span class="nav-link-text ms-1">Add to Database</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white <?php echo ($current_page == 'drivers_table_display.php') ? 'active' : ''; ?>"
                    href="drivers_table_display.php"
                    style="<?php echo ($current_page == 'drivers_table_display.php') ? 'background-color: #0dcaf0;' : ''; ?>">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">table_view</i>
                    </div>
                    <span class="nav-link-text ms-1">Tables</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" data-bs-toggle="collapse" href="#moreOptions" role="button"
                    aria-expanded="false" aria-controls="moreOptions"
                    style="<?php echo (strpos($current_page, 'subpage') !== false) ? 'background-color: #0dcaf0;' : ''; ?>">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">more_horiz</i>
                    </div>
                    <span class="nav-link-text ms-1">Tables</span>
                </a>
                <div class="collapse" id="moreOptions">
                    <ul class="nav flex-column ms-3">
                        <li class="nav-item">
                            <a class="nav-link text-white <?php echo ($current_page == 'drivers_table_display.php') ? 'active' : ''; ?>"
                                href="drivers_table_display.php"
                                style="<?php echo ($current_page == 'drivers_table_display.php') ? 'background-color: #0dcaf0;' : ''; ?>">Drivers</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white <?php echo ($current_page == 'trucks_table_display.php') ? 'active' : ''; ?>"
                                href="trucks_table_display.php"
                                style="<?php echo ($current_page == 'trucks_table_display.php') ? 'background-color: #0dcaf0;' : ''; ?>">Vehicles
                            </a>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
</aside>