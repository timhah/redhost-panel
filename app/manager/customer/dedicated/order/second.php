<?php
if(isset($_POST['order'])){
    if(!isset ($_POST['id'])){
        $_SESSION['error_msg'] = "Der Server existiert nicht!";
        header("Location: 1");
        die();
    }

    $price = 0;
    $ram = "";
    $cpu = "";
    $rom = "";
    $loc = "";
    $id = $_POST['id'];

    foreach ($hosterAPIDedi->getAvailable()->result as $dedi)
    {
        if($dedi->id == $_POST['id']){
            $price = $dedi->configuration->price;
            $ram = $dedi->configuration->ram->size."GB ".$dedi->configuration->ram->type;
            $cpu = $dedi->configuration->cpu->count." mal ".$dedi->configuration->cpu->type;
            $rom = $dedi->configuration->storage->count." mal ".$dedi->configuration->storage->size."GB ".$dedi->configuration->storage->type;
            $loc = $dedi->configuration->location->name;
        }
    }

    $price = $price * (($helper->getSetting("dedi_costs")+100)/100);

} else if(isset($_POST['order_2'])) {

    if(!isset ($_POST['id'])){
        $_SESSION['error_msg'] = "Der Server existiert nicht";
        header("Location: 1");
        die();
    } else if(!isset($_POST['os'])){
        $_SESSION['error_msg'] = "Das Betriebssystem existiert nicht";
        header("Location: 1");
        die();
    } else {
        $price = 0;
        foreach ($hosterAPIDedi->getAvailable()->result as $dedi) {
            if ($dedi->id == $_POST['id']) {
                $price = $dedi->configuration->price;
            }
        }

        $price = $price * (($helper->getSetting("dedi_costs") + 100) / 100);

        if ($amount < $price) {
            $_SESSION['error_msg'] = "Du hast zu wenig Guthaben";
            header("Location: 1");
            die();
        }

        $user->addTransaction($userid, $price, "Bestellung Dedicated Server");
        $user->removeMoney($price, $userid);

        $hosterAPIDedi->orderServer($_POST['id'], $_POST['os'], $_POST['ips'], $_POST['hostname']);

        $date = new DateTime(null, new DateTimeZone('Europe/Berlin'));
        $date->modify('+30 day');
        $expire_at = $date->format('Y-m-d H:i:s');

        $SQL = $db->prepare("INSERT INTO dedicated (user_id, server_id, price, expire_at) VALUES (:uid, :sid, :price, :exp)");
        $SQL->execute(array(":uid" => $userid, ":sid" => $_POST['id'], ":price" => $price, ":exp" => $expire_at));

        $_SESSION['success_msg'] = "Der Server wurde bestellt";
        header("Location: " . env("URL") . "manage/dedicated");
        die();
    }
} else {
    $_SESSION['error_msg'] = "Bitte wähle einen Server aus!";
    header("Location: 1");
    die();
}