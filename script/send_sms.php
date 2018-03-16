<?php
    error_reporting( E_ALL );
   
    //echo "Post:";
    //var_dump($_POST);
    //$json = $_POST['data'];
    $json = file_get_contents('php://input');
    if ($json == ""){
        die("POST data not available.".$json);
    }
    $out = json_decode($json);
    if($out === null) {
        die("JSON data not valid");
    }
    $number = $out->number;
    $text = $out->text;
    $command = "sudo /usr/local/bin/sendsms " . $number . " '" . $text . "'";
    $output = shell_exec($command);
    //echo "Comando: $command";
    echo "Result: $output";
?>