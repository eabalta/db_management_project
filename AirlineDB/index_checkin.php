
<?php
include "db.php";
include "./api/function.php";

// üye ekleme kısmı burada olacak. CREATE İşlemi
if ($_SERVER['REQUEST_METHOD'] == "POST") {

    // verilerimizi post yöntemi ile alalım.
    $check = $_POST['check'];
    $leg_instance = explode(" ", $_POST['Leg_instance']);
    // Kontrollerimizi yapalım.
    // gelen kullanıcı adı veya e-posta veri tabanında kayıtlı mı kontrol edelim.
    $passportNo = $db->query("SELECT Customer_pass from SEAT_RESERVATION WHERE Flight_number='$leg_instance[0]' AND Leg_number= '$leg_instance[1]' AND Date = '$leg_instance[2]' AND Seat_number = '$leg_instance[3]'")->fetch(PDO::FETCH_ASSOC);

    if (empty($passportNo) || empty($check) || empty($leg_instance)) {
        $_code = 400;
        $jsonArray["hata"] = true; // bir hata olduğu bildirilsin.
        $jsonArray["hataMesaj"] = "Boş Alan Bırakmayınız."; // Hatanın neden kaynaklı olduğu belirtilsin.
    } else {

        $ex = $db->prepare("UPDATE SEAT_RESERVATION SET check_in_flag= :check WHERE Customer_pass='$passportNo[Customer_pass]' AND Flight_number='$leg_instance[0]' AND Leg_number= '$leg_instance[1]' AND Date = '$leg_instance[2]' AND Seat_number = '$leg_instance[3]' ");
        $ekle = $ex->execute(array(
            "check" => $check,
        ));

        if (!empty($ekle)) {
            $_code = 201;
            $jsonArray["mesaj"] = "Islem Başarılı.";
        } else {
            $_code = 400;
            $jsonArray["hata"] = true; // bir hata olduğu bildirilsin.
            $jsonArray["hataMesaj"] = "Sistem Hatası.";
        }
    }
} else {
    $_code = 406;
    $jsonArray["hata"] = true;
    $jsonArray["hataMesaj"] = "Geçersiz method!";
}

if ($_SERVER['REQUEST_METHOD'] == "GET") {

    // verilerimizi post yöntemi ile alalım.
    if (isset($_GET["Passport_no"])) {
        $passportNo = $_GET['Passport_no'];

        // Kontrollerimizi yapalım.
        // gelen kullanıcı adı veya e-posta veri tabanında kayıtlı mı kontrol edelim.
        $customer = $db->query("SELECT * from SEAT_RESERVATION WHERE Customer_pass='$passportNo'");

        if (empty($passportNo)) {
            $_code = 400;
            $jsonArray["hata"] = true; // bir hata olduğu bildirilsin.
            $jsonArray["hataMesaj"] = "Boş Alan Bırakmayınız."; // Hatanın neden kaynaklı olduğu belirtilsin.
        } else if ($customer->rowCount() != 0) {
            $info = $db->query("SELECT * from SEAT_RESERVATION WHERE Customer_pass='$passportNo'")->fetchAll(PDO::FETCH_ASSOC);
        }
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

<?php include_once "header.php";?>

<?php include_once "nav.php"?>

  <div class="container-fluid">
      <div class="row mt-5">
          <div class="col-6">
              <p class="display-4 mb-4 rounded text-center p-2">CheckIn</p>

              <form action="" method="GET">
                   <div class="form-group">
                        <label for="passportno" class="lead">Passport Number</label>
                        <input name="Passport_no" type="text" class="form-control" id="passportno" placeholder="Enter passport number" required>
                    </div>
                    <button type="submit" class="btn btn-outline-secondary">Submit</button>
              </form>

              <form action="" class="mt-5" method="POST">
                    <div class="form-group">
                        <label for="exampleFormControlSelect2">Select Flight Leg Instance</label>
                        <select multiple class="form-control" name="Leg_instance" id="exampleFormControlSelect2">
                            <?php for ($i = 0; $i < count(array_keys($info)); $i++): ?>
                                <option value="<?php echo $info[$i]["Flight_number"] . " " . $info[$i]["Leg_number"] . " " . $info[$i]["Date"] . " " . $info[$i]["Seat_number"] ?>"><?php echo $info[$i]["Flight_number"] . " " . $info[$i]["Leg_number"] . " " . $info[$i]["Date"] . " " . $info[$i]["Seat_number"] ?></option>
                            <?php endfor;?>
                        </select>
                    </div>

                    <div class="form-group">
                        <input type="radio" class="btn-check" name="check" id="option1" value="1" autocomplete="off">
                        <label class="btn btn-secondary" for="option1">CheckIn</label>
                        <input type="radio" class="btn-check" name="check" id="option2" value="0" autocomplete="off">
                        <label class="btn btn-secondary" for="option2">Cancel</label>
                    </div>
                    <button type="submit" class="btn btn-outline-secondary">Submit</button>
                </form>
        </div>

        <div class="col-6">
            <?php if (empty($jsonArray["hataMesaj"])): ?>
                <p class="text-center lead my-auto"><?php echo $jsonArray["mesaj"] ?></p>
            <?php endif;?>

            <?php if (!empty($jsonArray["hataMesaj"])): ?>
                <p class="text-center lead my-auto"><?php echo $jsonArray["hataMesaj"] ?></p>
            <?php endif;?>

        </div>
    </div>
  </div>
</div>
</div>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

</body>

</html>