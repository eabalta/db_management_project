<?php
include "db.php";
include "./api/function.php";

if ($_SERVER['REQUEST_METHOD'] == "GET") {
    // üye bilgisi listeleme burada olacak. GET işlemi
    if (isset($_GET["Passport_no"]) && !empty(trim($_GET["Passport_no"]))) {
        $passportNo = intval($_GET["Passport_no"]);
        $userVarMi = $db->query("SELECT * from CUSTOMER WHERE Passport_no='$passportNo'")->rowCount();
        if ($userVarMi) {

            $bilgiler = $db->query("SELECT customer.Name, Country, ff_customer.Company, ff_customer.Rank_no, rnk.reward
      FROM customer, ff_customer, airlinedb.rank AS rnk
      WHERE Passport_no='$passportNo' AND rnk.Rank_no = ff_customer.Rank_no AND ff_customer.Company = rnk.Company AND (Passport_no) IN (SELECT Cust_pass
                              FROM ff_customer)")->fetch(PDO::FETCH_ASSOC);

            if (!empty($bilgiler)) {

            } else {
                $bilgiler = $db->query("SELECT * from CUSTOMER WHERE Passport_no='$passportNo'")->fetch(PDO::FETCH_ASSOC);
            }

            $jsonArray["uye-bilgileri"] = $bilgiler;
            $_code = 200;

        } else {
            $_code = 400;
            $jsonArray["hata"] = true; // bir hata olduğu bildirilsin.
            $jsonArray["hataMesaj"] = "Üye bulunamadı"; // Hatanın neden kaynaklı olduğu belirtilsin.
        }
    } else {
        $_code = 400;
        $jsonArray["hata"] = true; // bir hata olduğu bildirilsin.
        $jsonArray["hataMesaj"] = "Please enter passport number!"; // Hatanın neden kaynaklı olduğu belirtilsin.
    }
} else {
    $_code = 406;
    $jsonArray["hata"] = true;
    $jsonArray["hataMesaj"] = "Geçersiz method!";
}

//SetHeader($_code);
$jsonArray[$_code] = HttpStatus($_code);
//echo json_encode($jsonArray);
?>

<?php include_once "db.php";?>
<?php include_once "header.php";?>
<?php include_once "nav.php"?>
<div class="container-fluid">
      <div class="row mt-5">
            <div class="col">
            <p class="display-4 mb-4 rounded text-center p-2">Customer Details</p>
                      <form action="" method="GET">
                                <div class="form-group">
                                    <label for="passportno" class="lead">Passport Number</label>
                                    <input name="Passport_no" type="text" class="form-control" id="passportno" placeholder="Enter passport number" required>
                                </div>
                        <button type="submit" class="btn btn-outline-secondary">Submit</button>
                    </form>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="result p-5">

                    <?php if (empty($jsonArray["hataMesaj"])): ?>
                        <table class="table">
                                <thead>
                                    <tr>
                                    <?php for ($i = 0; $i < count(array_keys($jsonArray['uye-bilgileri'])); $i++): ?>
                                        <th scope="col"><?php echo array_keys($jsonArray['uye-bilgileri'])[$i] ?></th>
                                    <?php endfor;?>
                                    </tr>
                                </thead>
                                <tbody>
                                <tr>
                                <?php foreach ($jsonArray['uye-bilgileri'] as $st): ?>

                                    <td><?php echo $st ?></td>

                                <?php endforeach;?>
                                </tr>
                                </tbody>
                            </table>
                    <?php endif;?>

                    <?php if (!empty($jsonArray["hataMesaj"])): ?>
                      <p class="text-center lead"><?php echo $jsonArray["hataMesaj"] ?></p>
                    <?php endif;?>
                </div>
            </div>
        </div>
      </div>
    </div>
  </div>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

</body>

</html>