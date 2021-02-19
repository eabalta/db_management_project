<?php include "table1.php"?>

<?php

$yol = __FILE__;
$dosya = basename($yol, ".php"); // $dosya => "index"

try {
    $statement = $pdo->query('SELECT * FROM ' . $dosya)->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $statement = "<p>Wrong Query</p> </br>" . $e->getMessage();
}

?>

<?php include "table2.php"?>