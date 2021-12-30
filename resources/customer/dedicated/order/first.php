<?php
$currPage = 'front_Dedicated bestellen';
include BASE_PATH . 'app/controller/PageController.php';
$items = 0;
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
                <?php
                    foreach ($hosterAPIDedi->getAvailable()->result as $dedi)
                    {
                        $price = $dedi->configuration->price * (($helper->getSetting("dedi_costs")+100)/100);
                        ?>
                            <div class="col-md-4">
                                <div class="card">
                                    <form method="post" action="<?= env("URL") ?>order/dedicated/step/2">
                                        <div class="card-header card-title text-center">
                                            <?= $dedi->model ?> <br>
                                            <?= $price ?>€ / Monat
                                        </div>
                                        <div class="card-body">
                                            CPU: <?= $dedi->configuration->cpu->count ?> mal <?= $dedi->configuration->cpu->type ?> <br>
                                            RAM: <?= $dedi->configuration->ram->size ?>GB <?= $dedi->configuration->ram->type ?> <br>
                                            Storage: <?= $dedi->configuration->storage->count ?> mal <?= $dedi->configuration->storage->size ?>GB  <?= $dedi->configuration->storage->type ?><br><br>
                                            Standort: <?= $dedi->configuration->location->name ?> <br> <br> <br> <br>
                                        </div>
                                        <div class="card-footer">
                                            <input name="id" value="<?= $dedi->id ?>" hidden>
                                            <?php if($helper->getSetting("dedicated") == 0){ ?>
                                                <button class="btn btn-block btn-outline-primary mb-4 pulse-ring pulse-dark">Derzeit ist die Bestellung deaktiviert</button>
                                            <?php } else if($user->sessionExists($_COOKIE['session_token'])){ ?>
                                                <button class="btn btn-block btn-outline-primary mb-4 pulse-red" name="order" type="submit">Jetzt für <?= $price ?>€/Monat buchen</button>
                                            <?php } else { ?>
                                                <a href="<?= env('URL'); ?>" class="btn btn-block btn-outline-primary mb-4 pulse-red">
                                                    <b>Account erstellen</b>
                                                </a>
                                            <?php } ?>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        <?php
                        $items ++;
                    }
                    if($items == 0){
                        ?>
                        <div class="col-md-12">
                            <?php if($darkmode){ ?>
                                <div class="alert alert-dark text-center" role="alert">
                            <?php } else { ?>
                                <div class="alert alert-light text-center" role="alert">
                            <?php } ?>
                                    <h1 class="alert-heading">
                                        <br>
                                        Aktuell gibt es keine Dedis mehr.... 😲
                                    </h1>
                                    <br>
                                    <h4>
                                        Bald gibts hoffentlich neue....
                                    </h4>
                                    <br>
                                </div>
                            </div>
                        <?php
                    }
                ?>
            </div>
        </div>
    </div>
</div>