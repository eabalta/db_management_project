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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
  <link href="css/simple-sidebar.css" rel="stylesheet">
</head>

<body>

  <div class="d-flex" id="wrapper">
    <div class="bg-light border-right" id="sidebar-wrapper">
      <div class="sidebar-heading">Group 1</div>
      <div class="list-group list-group-flush">
      <?php foreach ($rows as $item): ?>
        <a href="<?php echo $item['Tables_in_' . $db_name] . '.php'; ?>" class="list-group-item list-group-item-action bg-light"><?php echo $item['Tables_in_' . $db_name]; ?></a>
      <?php endforeach;?>
      </div>
    </div>
    <div id="page-content-wrapper">
        <?php include "nav.php"?>
        <div class="container-fluid">
        </div>
        </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>


</body>

</html>