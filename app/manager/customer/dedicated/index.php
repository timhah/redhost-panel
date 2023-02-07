<?php
$items = 0;

if(isset($_POST['saveCustomName'])){
    $error = null;

    if(empty($_POST['service_id'])){
        $error = 'Produkt wurde nicht gefunden';
    }

    $SQLGetServerInfos = $db->prepare("SELECT * FROM `dedicated` WHERE `server_id` = :sid");
    $SQLGetServerInfos -> execute(array(":sid" => $_POST['server_id']));
    $serverInfos = $SQLGetServerInfos -> fetch(PDO::FETCH_ASSOC);
    if($userid != $serverInfos['user_id']){
        $error = 'Du hast keine Rechte auf dieses Produkt';
    }

    if(empty($error)){
        if(empty($_POST['custom_name'])){
            $custom_name = null;
            $msg = 'Name wurde entfernt';
        } else {
            $custom_name = $_POST['custom_name'];
            $msg = 'Name wurde gespeichert';
        }

        $SQL = $db->prepare("UPDATE `dedicated` SET `custom_name` = :custom_name WHERE `server_id` = :sid");
        $SQL -> execute(array(":custom_name" => $custom_name, ":sid" => $_POST['server_id']));

        echo sendSuccess($msg);
    } else {
        echo sendError($error);
    }
}
?>