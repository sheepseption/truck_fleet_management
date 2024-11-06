<?php function fetchData($connection, $table, $searchQuery, $currentPage, $parPage) {
// Determine the total number of entries based on the search
$sqlCount = "SELECT COUNT(*) AS nb_entries FROM $table WHERE license_plate LIKE ? OR make LIKE ? OR model LIKE ?;";
$stmtCount = mysqli_prepare($connection, $sqlCount);
$searchParam = "%" . $searchQuery . "%";
mysqli_stmt_bind_param($stmtCount, 'sss', $searchParam, $searchParam, $searchParam);
mysqli_stmt_execute($stmtCount);
$resultCount = mysqli_stmt_get_result($stmtCount);
$rowCount = mysqli_fetch_assoc($resultCount);
$nbEntries = (int) $rowCount['nb_entries'];

// Calculate total pages
$pages = ceil($nbEntries / $parPage);

// Calculate the first entry of the current page
$first = ($currentPage * $parPage) - $parPage;

// Query to fetch data for the current page
$fetch_query = "SELECT * FROM $table WHERE license_plate LIKE ? OR make LIKE ? OR model LIKE ? ORDER BY id LIMIT ?, ?;";
$stmt = mysqli_prepare($connection, $fetch_query);
mysqli_stmt_bind_param($stmt, 'ssii', $searchParam, $searchParam, $first, $parPage);
mysqli_stmt_execute($stmt);
$fetch_query_run = mysqli_stmt_get_result($stmt);

return [$fetch_query_run, $nbEntries, $pages];
}
?>