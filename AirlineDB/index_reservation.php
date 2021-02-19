
<?php
include "db.php";
include "./api/function.php";

$flight = $db->query("SELECT Flight_number,Leg_number,Date from leg_instance")->fetchAll(PDO::FETCH_ASSOC);

// üye ekleme kısmı burada olacak. CREATE İşlemi
if ($_SERVER['REQUEST_METHOD'] == "POST") {

    // verilerimizi post yöntemi ile alalım.
    $passportNo = $_POST['Passport_no'];
    $leg_instance = explode(" ", $_POST['Leg_instance']);
    $seatnumber = $_POST['SeatNumber'];
    if (!isset($_POST['Checkin'])) {
        $checkin = 0;
    } else {
        $checkin = 1;
    }

    // Kontrollerimizi yapalım.

    if (empty($passportNo) || empty($leg_instance) || empty($seatnumber)) {
        $_code = 400;
        $jsonArray["hata"] = true; // bir hata olduğu bildirilsin.
        $jsonArray["hataMesaj"] = "Boş Alan Bırakmayınız."; // Hatanın neden kaynaklı olduğu belirtilsin.
    } else {

        $ex = $db->prepare("INSERT INTO SEAT_RESERVATION SET
			Customer_pass= :passno,
			Flight_number= :fnum,
			Leg_number= :lnum,
			Date= :date,
            Seat_number= :snum,
            check_in_flag= :cflag");
        $ekle = $ex->execute(array(
            "passno" => $passportNo,
            "fnum" => $leg_instance[0],
            "lnum" => $leg_instance[1],
            "date" => $leg_instance[2],
            "snum" => $seatnumber,
            "cflag" => $checkin,
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
            <p class="display-4 mb-4 rounded text-center p-2">Seat Reservation</p>
                            <form action="" method="POST">
                                <div class="form-group">
                                    <label for="passportno" class="lead">Passport Number</label>
                                    <input name="Passport_no" type="text" class="form-control" id="passportno" placeholder="Enter passport number" required>
                                </div>


                                <div class="form-group">
                                    <label for="exampleFormControlSelect2">Select Flight Leg Instance</label>
                                <select multiple class="form-control" name="Leg_instance" id="exampleFormControlSelect2">

                                    <?php for ($i = 0; $i < count(array_keys($flight)); $i++): ?>
                                    <option value="<?php echo $flight[$i]["Flight_number"] . " " . $flight[$i]["Leg_number"] . " " . $flight[$i]["Date"] ?>"><?php echo $flight[$i]["Flight_number"] . " " . $flight[$i]["Leg_number"] . " " . $flight[$i]["Date"] ?></option>
                                    <?php endfor;?>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="seatnumber" class="lead">Seat Number</label>
                                    <input name="SeatNumber" type="text" class="form-control" id="seatnumber" placeholder="Enter seat number" required>
                                </div>

                                <div class="form-group">
                                    <div class="form-check">
                                        <input class="form-check-input" name="Checkin" type="checkbox" value="" id="flexCheckDefault">
                                        <label class="form-check-label" for="flexCheckDefault">
                                            Check-In
                                        </label>
                                    </div>
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