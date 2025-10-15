# Fleet Management Dashboard — School Project

> A web-based **Fleet Management System** built with **PHP**, **MySQL**, and **Bootstrap**.  
> The project provides a full-featured admin interface to manage **trucks**, **drivers**, and **deliveries**.  
> It includes SQL database scripts, PHP backend logic, and a modern responsive UI.

---

## Project Overview

This project was developed as part of a university database and web systems course.  
It demonstrates the integration of a **relational database (SQL)** with a **dynamic PHP frontend**, following a modular and reusable architecture.

The system allows administrators to:

- Manage **drivers**, **trucks**, and **vehicles**
- Schedule and track **deliveries**
- Display key statistics in real-time using dashboard cards
- Interact with a **MySQL database** through prepared queries
- View, insert, and edit data via a user-friendly web interface

## Features

###  Driver Management
- Add, edit, and remove drivers
- Assign drivers to specific vehicles
- Display all drivers in a dynamic table

### Truck Management
- Add or edit truck information
- Manage availability and maintenance status

### Deliveries
- Plan, assign, and track deliveries
- Fetch and display delivery details dynamically
- Update status through the admin panel

### Dashboard & Statistics
- Overview of total trucks, drivers, and deliveries
- Modern interface using **Material Dashboard** styling

---

## Database

The SQL scripts under `/database` define all database structures and test data.

Run the setup in your MySQL environment:
```bash
mysql -u root -p < database/base.sql
mysql -u root -p < database/insert.sql
```

Database connection configuration is in:
```
admin/dbconfig/dbconfig.php
```

Example content:
```php
<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fleet_management";
$conn = mysqli_connect($host, $username, $password, $database);
?>
```

