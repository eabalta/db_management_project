<?php

    $db_host        = "localhost";
    $db_port        = "3306";
    $db_name        = "airlinedb";
    $db_username    = "root";
    $db_password    = "";

    $pdo = new PDO('mysql:host='.$db_host.';port='.$db_port.';dbname='.$db_name,$db_username,$db_password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $statement = [];

    if($_SERVER['REQUEST_METHOD'] === 'POST'){

        $sql = $_POST['sql'];
        
        if(!empty($sql)){
           try{
            $statement =  $pdo->query($sql)->fetchAll( PDO::FETCH_ASSOC );
           }catch(PDOException $e){
                $statement = "<p>Wrong Query</p> </br>".$e->getMessage();
           }
        }

    }

?>

<?php include_once "header.php"; ?>
<?php include_once "nav.php"?>

      <div class="container-fluid">
      <div class="row mt-5">
            <div class="col">
                     <p class="display-4 mb-4 rounded text-center p-2">SQL Query</p>
                      <form action="" method="POST">

                        <div class="form-group">
                            <textarea class="form-control" id="sqlTextarea" rows="10" name="sql"></textarea>
                        </div>
                        <button type="submit" class="btn btn-outline-secondary">Submit</button>
                    </form>
            </div>
        </div>
    

    
        <div class="row">
            <div class="col">
                <div class="result p-5">

                    <?php if(!empty($statement) && is_array($statement)): ?>
                        <table class="table">
                                <thead>
                                    <tr>
                                    <?php for($i = 0 ; $i < count(array_keys($statement[0])) ; $i++): ?>
                                        <th scope="col"><?php echo array_keys($statement[0])[$i] ?></th>
                                    <?php endfor; ?>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php  foreach($statement as $st): ?>
                                    <tr>
                                    <?php  foreach(array_values($st) as $s): ?>
                                                <td><?php echo $s ?></td>
                                    <?php endforeach; ?>
                                    </tr>
                                <?php endforeach; ?>
                                </tbody>
                            </table>
                    <?php endif; ?>
                </div>
            </div>
        </div>
      </div>
    </div>
    <!-- /#page-content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Bootstrap core JavaScript -->

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

</body>

</html>