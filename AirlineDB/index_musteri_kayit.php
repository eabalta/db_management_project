
<?php
include "db.php";
include "./api/function.php";
if ($_SERVER['REQUEST_METHOD'] == "POST") {

    // verilerimizi post yöntemi ile alalım.
    $passportNo = $_POST['Passport_no'];
    $name = $_POST['Name'];
    $phone = $_POST['Phone'];
    $email = $_POST['Email'];
    $country = $_POST['Country'];
    $address = $_POST['Address'];

    // Kontrollerimizi yapalım.
    // gelen kullanıcı adı veya e-posta veri tabanında kayıtlı mı kontrol edelim.
    $customers = $db->query("SELECT * from CUSTOMER WHERE Passport_no='$passportNo'");

    if (empty($passportNo) || empty($name) || empty($phone) || empty($email) || empty($country) || empty($address)) {
        $_code = 400;
        $jsonArray["hata"] = true; // bir hata olduğu bildirilsin.
        $jsonArray["hataMesaj"] = "Boş Alan Bırakmayınız."; // Hatanın neden kaynaklı olduğu belirtilsin.
    } else if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $_code = 400;
        $jsonArray["hata"] = true; // bir hata olduğu bildirilsin.
        $jsonArray["hataMesaj"] = "Geçersiz E-Posta Adresi"; // Hatanın neden kaynaklı olduğu belirtilsin.
    } else if ($customers->rowCount() != 0) {
        $_code = 400;
        $jsonArray["hata"] = true; // bir hata olduğu bildirilsin.
        $jsonArray["hataMesaj"] = "Pasaport numarasina sahip bir musteri bulunmaktadir.";
    } else {

        $ex = $db->prepare("INSERT INTO CUSTOMER SET
			Passport_no= :passno,
			Name= :nam,
			Phone= :phone,
			Email= :mail,
			Country= :country,
			Address= :addr");
        $ekle = $ex->execute(array(
            "passno" => $passportNo,
            "nam" => $name,
            "phone" => $phone,
            "mail" => $email,
            "country" => $country,
            "addr" => $address,
        ));

        if (!empty($ekle)) {
            $_code = 201;
            $jsonArray["mesaj"] = "Ekleme Başarılı.";
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

//SetHeader($_code);
$jsonArray[$_code] = HttpStatus($_code);
//echo json_encode($jsonArray);
?>


<?php include_once "header.php";?>

<?php include_once "nav.php"?>

  <div class="container-fluid">
      <div class="row mt-5">
            <div class="col-6">
            <p class="display-4 mb-4 rounded text-center p-2">Add Customer</p>
                            <form action="" method="POST">
                                <div class="form-group">
                                    <label for="passportno" class="lead">Passport Number</label>
                                    <input name="Passport_no" type="text" class="form-control" id="passportno" placeholder="Enter passport number" required>
                                </div>

                                <div class="form-group">
                                    <label for="name" class="lead">Name & Surname</label>
                                    <input name="Name" type="text" class="form-control" id="name" placeholder="Enter name and surname" required>
                                </div>

                                <div class="form-group">
                                    <label for="phone" class="lead">Phone</label>
                                    <input name="Phone" type="text" class="form-control" id="phone" placeholder="Enter phone number" required>
                                </div>

                                <div class="form-group">
                                    <label for="email" class="lead">Email</label>
                                    <input name="Email" type="email" class="form-control" id="email" placeholder="Enter email address" required>
                                </div>

                                <div class="form-group">
                                    <label for="country" class="lead">Country</label>
                                    <input name="Country" type="text" class="form-control" id="country" placeholder="Enter abbreviation of your country " required>
                                    <small id="countryHelp" class="form-text text-muted">Like TR, UK etc.</small>
                                </div>

                                <div class="form-group">
                                    <label for="address" class="lead">Address</label>
                                    <input name="Address" type="text" class="form-control" id="address" placeholder="Enter your address" required>
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