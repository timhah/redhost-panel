<?php

if(!($serverInfos['deleted_at'] == NULL)){
    header('Location: '.$helper->url().'order/dedicated');
    die();
}

if(!is_null($serverInfos['locked'])){
    $_SESSION['product_locked_msg'] = $serverInfos['locked'];
    header('Location: '.env('URL').'manage/rootserver');
    die();
}
if($serverInfos['state'] == 'suspended'){
    $suspended = true;
    die(header('Location: '.$helper->url().'renew/dedicated/'.$id));
} else {
    $suspended = false;
}

if($userid != $serverInfos['user_id']){
    die(header('Location: '.$helper->url().'manage/dedicated'));
}

$server_id = $serverInfos["server_id"];
$status = $hosterAPIDedi->getStatus($server_id);
$config = $hosterAPIDedi->getConfig($server_id)->result;
if($status->result->state == 'running'){
    $state = '<span class="badge badge-success">Online</span>';
    $serverStatus = 'ONLINE';
} else {
    $serverStatus = 'OFFLINE';
    $state = '<span class="badge badge-danger">Offline</span>';
}

if (isset($_POST['sendStop'])) {
    $error = null;

    if ($status->result->state == 'halted') {
        $error = 'Dein Server ist bereits gestoppt';
    }

    if (empty($error)) {

        $serverStatus = 'OFFLINE';
        $hosterAPIDedi->stop($server_id);
        echo sendSweetSuccess('Dein Server wird nun gestoppt');

    } else {
        echo sendError($error);
    }
}

if (isset($_POST['sendStart'])) {
    $error = null;

    if ($status->result->state == 'running') {
        $error = 'Dein Server ist bereits gestartet';
    }

    if (empty($error)) {

        $serverStatus = 'ONLINE';
        $hosterAPIDedi->start($server_id);
        echo sendSweetSuccess('Dein Server wird nun gestartet');

    } else {
        echo sendError($error);
    }
}

if (isset($_POST['sendRestart'])) {
    $error = null;

    if ($status->result->state == 'stopped') {
        $error = 'Dein Server ist bereits gestoppt';
    }

    if (empty($error)) {

        $serverStatus = 'ONLINE';
        $hosterAPIDedi->reboot($server_id);
        echo sendSweetSuccess('Dein Server wurde nun neugestartet');

    } else {
        echo sendError($error);
    }
}

if($serverStatus == 'ONLINE'){
    $state = '<span class="badge badge-success">Online</span>';
}

if($serverStatus == 'OFFLINE'){
    $state = '<span class="badge badge-danger">Offline</span>';
}

if(isset($_POST['reinstallServer'])){

    $error = null;

    if(!isset($_POST['serverOS'])){
        $error = "Betriebssystem wurde nicht gefunden!";
    }

    if(is_null($error)){

        $hosterAPIDedi->reinstall($server_id, $_POST['serverOS'], $_POST['hostname']);

        $_SESSION['success_msg'] = "Dein Server wird nun neu installiert. Bitte habe einen Augenblick geduld!";

        header("refresh: 1");

    } else {
        echo sendError($error);
    }

}

if(isset($_POST['installSoftware'])){
    $hosterAPIDedi->installSoftware($config->ips[0], $config->ssh->root->password, $_POST['software']);
    echo sendSweetSuccess("Die Software wird nun installiert");
}
if(isset($_POST['uninstallSoftware'])){
    $hosterAPIDedi->uninstallSoftware($config->ips[0], $config->ssh->root->password, $_POST['software']);
    echo sendSweetSuccess("Die Software wird nun entfernt");
}

if(isset($_POST['openConsole'])){
    echo '<script type="text/javascript" language="Javascript">window.open("'.$hosterAPIDedi->getVNC($server_id)->result.'");</script>';
}
