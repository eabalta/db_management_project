
        
                <div class="container-fluid">



<p class="display-4 m-4 border rounded text-center p-2"><?php echo $dosya ?></p>




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

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>


</body>

</html>