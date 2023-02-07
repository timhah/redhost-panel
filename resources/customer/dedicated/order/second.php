<?php
$currPage = 'front_Dedicated bestellen';
include BASE_PATH . 'app/controller/PageController.php';
include BASE_PATH . 'app/manager/customer/dedicated/order/second.php';
?>
<div class="content d-flex flex-column flex-column-fluid" id="kt_content">
    <?php if($user->sessionExists($_COOKIE['session_token'])){ ?>
        <div class="subheader py-2 py-lg-4 subheader-solid" id="kt_subheader">
            <div class="container-fluid d-flex align-items-center justify-content-between flex-wrap flex-sm-nowrap">
                <div class="d-flex align-items-center flex-wrap mr-2">
                    <h5 class="text-dark font-weight-bold mt-2 mb-2 mr-5"><?= env('APP_NAME'); ?></h5>
                    <div class="subheader-separator subheader-separator-ver mt-2 mb-2 mr-4 bg-gray-200"></div>
                    <span class="text-muted font-weight-bold mr-4"><?= $currPageName; ?></span>
                </div>
            </div>
        </div>
        <div class="text-center" style="margin-top: 50px; margin-bottom: 50px;">
            <h1 style="font-size: 70px;">Prepaid <b style="color: #9e2033;">Dedicated Server</b></h1>
            <hr style="width: 40%;">
        </div>
    <?php } ?>

    <div class="d-flex flex-column-fluid">
        <div class="container">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <div class="text-center">
                                <h3>Deine Konfiguration</h3>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="text-center">
                                <form method="post">
                                    <p>
                                        CPU: <?=$cpu?><br>
                                        RAM: <?=$ram?><br>
                                        Storage: <?=$rom?><br>
                                        Standort: <?=$loc?><br>
                                        Preis: <?=$price?>€
                                    </p>

                                    <hr>
                                    <br>
                                    IP-Adressen: <br>
                                    <br>
                                    <select name="ips" class="form-control">
                                        <option class="form-control" value="1">1</option>
                                        <option class="form-control" value="2">2</option>
                                        <option class="form-control" value="3">3</option>
                                        <option class="form-control" value="4">4</option>
                                        <option class="form-control" value="5">5</option>
                                    </select>
                                    <br>
                                    <br>
                                    Hostname: <br>
                                    <br>
                                    <input required type="text" class="form-control" name="hostname">
                                    <br>
                                    <br>
                                    Betriebssystem: <br>
                                    <br>
                                    <select name="os" class="form-control">
                                        <?php foreach ($hosterAPIDedi->getTemplates()->result as $os) { ?>
                                            <option class="form-control" value="<?= $os ?>"><?= $os ?></option>
                                        <?php } ?>
                                    </select>
                                    <br>
                                    <hr>
                                    <br>
                                    <label for="agb" class="checkbox noselect">
                                        <input required type="checkbox" name="agb" id="agb">
                                        <span></span>
                                        Ich habe die <a href="<?= $helper->url(); ?>agb">AGB</a> und <a href="<?= $helper->url(); ?>datenschutz">Datenschutzerklärung</a> gelesen und akzeptiere diese.
                                    </label>
                                    <br>
                                    <br>
                                    <label for="wiederruf" class="checkbox noselect">
                                        <input required type="checkbox" name="wiederruf" id="wiederruf">
                                        <span></span>
                                        Ich wünsche die vollständige Ausführung der Dienstleistung vor Fristablauf des Widerufsrechts gemäß Fernabsatzgesetz. Die automatische Einrichtung und Erbringung der Dienstleistung führt zum Erlöschen des Widerrufsrechts.
                                    </label>
                                    <br>
                                    <br>
                                    <br>
                                    <input hidden name="id" value="<?=$_POST['id']?>">
                                    <button type="submit" class="btn btn-block btn-outline-primary mb-4 pulse-red" name="order_2">Jetzt kostenpflichtig für <?=$price?>€ pro Monat bestellen.</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4"></div>
            </div>
        </div>
    </div>

</div>