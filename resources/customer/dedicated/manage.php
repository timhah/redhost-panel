<?php
$currPage = 'back_Dedicated verwalten';
include BASE_PATH.'app/controller/PageController.php';

$id = $helper->protect($_GET['id']);

$SQLGetServerInfos = $db->prepare("SELECT * FROM `dedicated` WHERE `id` = :id");
$SQLGetServerInfos -> execute(array(":id" => $id));
$serverInfos = $SQLGetServerInfos -> fetch(PDO::FETCH_ASSOC);

include BASE_PATH . "app/manager/customer/dedicated/manage.php";
?>
<div class="content d-flex flex-column flex-column-fluid" id="kt_content">
    <div class="subheader py-2 py-lg-4 subheader-solid" id="kt_subheader">
        <div class="container-fluid d-flex align-items-center justify-content-between flex-wrap flex-sm-nowrap">
            <div class="d-flex align-items-center flex-wrap mr-2">
                <h5 class="text-dark font-weight-bold mt-2 mb-2 mr-5"><?= env('APP_NAME'); ?></h5>
                <div class="subheader-separator subheader-separator-ver mt-2 mb-2 mr-4 bg-gray-200"></div>
                <span class="text-muted font-weight-bold mr-4"><?= $currPageName; ?></span>
            </div>
        </div>
    </div>

    <div class="d-flex flex-column-fluid">
        <div class="container">
            <div class="row">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-main-tab" data-toggle="tab" href="#nav-main" role="tab" aria-controls="nav-main" aria-selected="true">Übersicht</a>
                    <a class="nav-item nav-link" id="nav-software-tab" data-toggle="tab" href="#nav-software" role="tab" aria-controls="nav-software" aria-selected="false">Software</a>
                </div>
            </nav>

            <br>

            <div class="row">
                <div class="col-md-8">
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-main" role="tabpanel" aria-labelledby="nav-main-tab">
                            <div class="card shadow mb-5">
                                <div class="card-header"><h1>Informationen</h1></div>
                                <div class="card-body">

                                    <div class="row">

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>Server-ID:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <span class="ml-2"><?= $serverInfos['id']; ?></span>
                                            </p>
                                        </div>

                                        <?php if(is_null($serverInfos['custom_name'])){ ?>
                                        <?php } else { ?>
                                            <div class="col-md-6">
                                                <p class="text-muted mb-2 font-13">
                                                    <strong>Produkt Name:</strong>
                                                </p>
                                            </div>

                                            <div class="col-md-6">
                                                <p class="text-muted mb-2 font-13">
                                                    <span class="ml-2"><?= $helper->xssFix($serverInfos['custom_name']); ?></span>
                                                </p>
                                            </div>
                                        <?php } ?>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>Laufzeit:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <span class="ml-2">
                                                    <span id="countdown">Lädt...</span>
                                                </span>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>Betriebssystem:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <span class="ml-2"><?= $config->template ?></span>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>Hostname:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <?= $config->hostname ?></span> <i class="fas fa-question-circle" style="cursor: help" data-toggle="tooltip" data-placement="top" title="" aria-hidden="true" data-original-title="Der Hostname kann nicht zum verbinden per SSH-Client genutzt werden, nutzen kannst du stattdessen die IP unter 'Netzwerk'"></i>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>Status: </strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <span class="ml-2"><?= $state; ?></span>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>Passwort:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <span class="ml-2">
                                                    <span id="root_password">************************</span>
                                                    <span style="cursor: pointer;" id="root_icon" onclick="passwordEye('root');">
                                                        <i class="far fa-eye"></i>
                                                    </span>

                                                    <i style="cursor: pointer;" class="fas fa-copy copy-btn" data-clipboard-text="<?=$config->ssh->root->password?>" data-toggle="tooltip" title="Passwort kopieren"></i>
                                                </span>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>User-Zugang:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <span class="ml-2">
                                                    <span id="user_username"><?= $config->ssh->user->username ?></span> <br>
                                                    <span id="user_password">************************</span>
                                                    <span style="cursor: pointer;" id="user_icon" onclick="passwordEye('user');">
                                                        <i class="far fa-eye"></i>
                                                    </span>

                                                    <i style="cursor: pointer;" class="fas fa-copy copy-btn" data-clipboard-text="<?=$config->ssh->user->password?>" data-toggle="tooltip" title="Passwort kopieren"></i>
                                                </span>
                                            </p>
                                        </div>


                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>Preis:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <span class="ml-2"><?= $serverInfos['price'] ?>€ / Monat</span>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>CPU:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <span class="ml-2"><?= $config->configuration->cpu->count ?>x <?= $config->configuration->cpu->type ?></span>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>IP-Adressen:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <?php foreach ($config->ips as $ip) {?>
                                                    <span class="ml-2"><?= $ip; ?></span>
                                                <?php } ?>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>MAC-Adressen:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <span class="ml-2"><?= $config->mac ?></span>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>Arbeitsspeicher:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <span class="ml-2"><span id="memory_text"><?= $config->configuration->ram->size ?>GB <?= $config->configuration->ram->type ?></span></span>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <strong>Festplatte:</strong>
                                            </p>
                                        </div>

                                        <div class="col-md-6">
                                            <p class="text-muted mb-2 font-13">
                                                <span class="ml-2"><?= $config->configuration->storage->count ?>x <?= $config->configuration->storage->size ?>GB <?= $config->configuration->storage->type ?></span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="nav-software" role="tabpanel" aria-labelledby="nav-software-tab">
                            <div class="row">
                                    <?php
                                    $software = $venocix->getSoftware();
                                    foreach($software->result as $softwareKey=>$softwareInfo)
                                    {
                                        $name = $softwareInfo->name;
                                        $desc = $softwareInfo->description->de;
                                        $url = $softwareInfo->url;
                                        $icon = $softwareInfo->icon;

                                        if($icon == ""){
                                            $icon = "https://files.robin-it.de/logo_quadrat.png";
                                        }

                                        ?>
                                            <div class="col-md-6">
                                                <div class="card shadow mb-5">
                                                    <form method="post">
                                                    <div class="card-header">
                                                        <?=$name?>
                                                    </div>
                                                    <div class="card-body">
                                                        <?=$desc?>
                                                        <?php if($url != "") { ?>
                                                            <br>
                                                            <br>
                                                            <a href="<?=$url?>">Mehr Informationen</a>
                                                        <?php } ?>
                                                    </div>
                                                        <div class="card-footer">
                                                            <div class="text-center">
                                                                <form method="post">
                                                                    <input hidden name="software" value="<?=$softwareKey?>">
                                                                    <button type="submit" name="uninstallSoftware" class="btn btn-primary btn-sm">Deinstallieren</button>
                                                                    <button type="submit" name="installSoftware" class="btn btn-success btn-sm">Installieren</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                </div>
                                            </div>
                                        <?php
                                    }
                                    ?>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow mb-5">
                        <div class="card-header"><h1>Server steuern</h1></div>
                        <!--div class="card-header"><h3>Server steuern</h3></div-->
                        <div class="card-body">

                            <?php if($serverStatus == 'ONLINE'){ ?>
                                <form method="post" id="stopServer">
                                    <input name="sendStop" hidden>
                                    <button type="button" style="cursor: not-allowed;" disabled class="btn btn-outline-success btn-block">
                                        <b><i class="fas fa-play"></i>&nbsp;  Starten </b>
                                    </button>
                                    <button type="button" onclick="stop();" class="btn btn-outline-primary btn-block">
                                        <b><i class="fas fa-stop"></i>&nbsp; Stoppen </b>
                                    </button>
                                </form>
                                <br>
                                <form method="post" id="restartServer">
                                    <input name="sendRestart" hidden>
                                    <button type="button" onclick="restart();" class="btn btn-outline-warning btn-block">
                                        <b><i class="fas fa-power-off"></i>&nbsp; Neustarten </b>
                                    </button>
                                </form>
                            <?php } else { ?>
                                <form method="post">
                                    <button type="submit" name="sendStart" class="btn btn-outline-success btn-block">
                                        <b><i class="fas fa-play"></i>&nbsp; Starten </b>
                                    </button>
                                    <button type="submit" style="cursor: not-allowed;" disabled class="btn btn-outline-primary btn-block" data-toggle="tooltip" title="Der Server ist bereits gestoppt">
                                        <b><i class="fas fa-stop"></i>&nbsp; Stoppen </b>
                                    </button>
                                    <br>
                                    <button type="submit" style="cursor: not-allowed;" disabled class="btn btn-outline-warning btn-block" data-toggle="tooltip" title="Der Server ist nicht gestartet">
                                        <b><i class="fas fa-power-off"></i>&nbsp; Neustarten </b>
                                    </button>
                                </form>
                            <?php } ?>

                            <br><hr><br>

                            <button type="button" data-toggle="modal" data-target="#reinstall" class="btn btn-outline-warning btn-block"><b><i class="fas fa-cogs"></i> Neuinstallieren</b></button>
                            <br>
                            <form method="post">
                                <button type="submit" name="openConsole" class="btn btn-outline-warning btn-block"><b><i class="fas fa-terminal"></i> Console</b></button>
                            </form>

                            <br><hr><br>

                            <a class="btn btn-block btn-outline-warning" href="<?= $helper->url(); ?>renew/dedicated/<?= $id; ?>"><b><i class="fas fa-history"></i>&nbsp; Verlängern</b></a>

                        </div>
                    </div>
                </div>

                <br>
                <br>

            </div>
        </div>
    </div>

    <div class="modal fade" id="newRootpasswordModal" tabindex="-1" role="dialog" aria-labelledby="newRootpasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="newRootpasswordModalLabel">Neues Root-Passwort setzen</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <label for="root_password">Root-Passwort</label>
                    <input disabled value="Es wird ein neues Passwort generiert.">

                </div>
                <div class="modal-footer">
                    <form method="post">
                        <button type="button" class="btn btn-outline-primary text-uppercase font-weight-bolder" data-dismiss="modal"><i class="fas fa-ban"></i> Nein lieber doch nicht</button>
                        <button type="submit" name="resetRootPW" class="btn btn-outline-success text-uppercase font-weight-bolder"><i class="fas fa-share-square"></i> Zurücksetzen</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="reinstall" tabindex="-1" role="dialog" aria-labelledby="reinstallModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="reinstallModalLabel">Neuinstallation</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <form method="post" id="reinstallServer">

                        <label for="serverOS">Wähle dein neues Betriebssystem aus</label>
                        <select name="serverOS" class="form-control">
                            <?php foreach ($hosterAPIDedi->getTemplates()->result as $os) { ?>
                                <option class="form-control" value="<?= $os ?>"><?= $os ?></option>
                            <?php } ?>
                        </select>
                        <br>
                        <label for="hostname">Wähle dein neues Betriebssystem aus</label>
                        <input type="text" class="form-control" name="hostname" value="<?= $config->hostname ?>">

                        <br>
                        <input hidden name="reinstallServer">
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary text-uppercase font-weight-bolder" data-dismiss="modal"><i class="fas fa-ban"></i> Nein lieber doch nicht</button>
                    <button type="button" onclick="reinstallServer();" class="btn btn-outline-success text-uppercase font-weight-bolder"><i class="fas fa-share-square"></i> Neuinstallation starten</button>
                    <!--onclick="resetPassword();" -->
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    function reinstallServer() {
        Swal.fire({
            title: 'Server neuinstallieren?',
            text: "Wenn du auf 'Ja' klickst werden alle Daten auf dem Server unwiederruflich gelöscht",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Ja',
            cancelButtonText: 'Nein'
        }).then((result) => {
            if (result.value) {
                document.getElementById('reinstallServer').submit();
            }
        })
    }

    function stop() {
        Swal.fire({
            title: 'Server wirklich stoppen?',
            text: "Wenn du auf 'Ja' klickst wird der Server gestoppt",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Ja',
            cancelButtonText: 'Nein'
        }).then((result) => {
            if (result.value) {
                document.getElementById('stopServer').submit();
            }
        })
    }

    function restart() {
        Swal.fire({
            title: 'Server wirklich neustarten?',
            text: "Wenn du auf 'Ja' klickst wird der Server neugestartet",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Ja',
            cancelButtonText: 'Nein'
        }).then((result) => {
            if (result.value) {
                document.getElementById('restartServer').submit();
            }
        })
    }

    let dediroot = true;
    let dediuser = true;
    function passwordEye(type) {
        if(type === 'root'){
            if(dediroot){
                $('#root_password').html("<?=$config->ssh->root->password?>");
                $('#root_icon').html('<i class="far fa-eye-slash"></i>');
                dediroot = false;
            } else {
                $('#root_password').html('************************');
                $('#root_icon').html('<i class="far fa-eye"></i>');
                dediroot = true;
            }
        }else if(type === 'user'){
            if(dediuser){
                $('#user_password').html("<?=$config->ssh->user->password?>");
                $('#user_icon').html('<i class="far fa-eye-slash"></i>');
                dediuser = false;
            } else {
                $('#user_password').html('************************');
                $('#user_icon').html('<i class="far fa-eye"></i>');
                dediuser = true;
            }
        }
    }
</script>
<script>
    var countDownDate = new Date("<?= $serverInfos['expire_at']; ?>").getTime();
    var x = setInterval(function() {

        var now = new Date().getTime();
        var distance = countDownDate - now;

        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        if(days == 1){ var days_text = ' Tag' } else { var days_text = ' Tage'; }
        if(hours == 1){ var hours_text = ' Stunde' } else { var hours_text = ' Stunden'; }
        if(minutes == 1){ var minutes_text = ' Minute' } else { var minutes_text = ' Minuten'; }
        if(seconds == 1){ var seconds_text = ' Sekunde' } else { var seconds_text = ' Sekunden'; }

        if(days == 0 && !(hours == 0 && minutes == 0 && seconds == 0)){
            $('#countdown<?= $row["id"]; ?>').html(hours+hours_text+', '+  minutes+minutes_text+' und ' +  seconds+seconds_text);
            if(days == 0 && hours == 0 && !(minutes == 0 && seconds == 0)){
                $('#countdown<?= $row["id"]; ?>').html(minutes+minutes_text+' und '+  seconds+seconds_text);
                if(days == 0 && hours == 0 && minutes == 0 && !(seconds == 0)){
                    $('#countdown<?= $row["id"]; ?>').html(seconds+seconds_text);
                }
            }
        } else {
            $('#countdown').html(days+days_text+', '+  hours+hours_text+', '+  minutes+minutes_text+' und '+  seconds+seconds_text);
        }

        if (distance <= 0) {
            clearInterval(x);
        }
    }, 1000);
</script>