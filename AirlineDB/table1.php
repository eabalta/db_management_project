<?php

$db_host = "localhost";
$db_port = "3306";
$db_name = "airlinedb";
$db_username = "root";
$db_password = "";

$pdo = new PDO('mysql:host=' . $db_host . ';port=' . $db_port . ';dbname=' . $db_name, $db_username, $db_password);
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$query = $pdo->prepare('show tables from ' . $db_name);
$query->execute();
$rows = $query->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Group 1 - Database Management</title>

  <!-- Bootstrap core CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

  <!-- Custom styles for this template -->
  <link href="./css/simple-sidebar.css" rel="stylesheet">

</head>

<body>

  <div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class="bg-light border-right" id="sidebar-wrapper">
      <div class="sidebar-heading">Group 1</div>
      <div class="list-group list-group-flush">
      <?php foreach ($rows as $item): ?>
        <a href="<?php echo $item['Tables_in_' . $db_name] . '.php'; ?>" class="list-group-item list-group-item-action bg-light"><?php echo $item['Tables_in_' . $db_name]; ?></a>

        <!-- db_tables olusturmak icin create'i buraya ekle -->

      <?php endforeach;?>
      </div>
    </div>

    <!-- Page Content -->
    <div id="page-content-wrapper">

    <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">


<div class="collapse navbar-collapse" id="navbarSupportedContent">
  <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
    <li class="nav-item active">
      <a class="nav-link" href="index.php">Home <span class="sr-only">(current)</span></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="tables.php">Tables</a>
    </li>
  </ul>
</div>
</nav>