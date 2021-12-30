# RedHost Panel Installation

Kopie von B. Schleyer

Hallo,

hier erklärt, findest Du die Installationsanleitung für Plesk. Erklärungsweise in Schritten:

Schritt 1: Zunächst legen wir eine Domain oder x-beliebige Subdomain in Plesk an.

Schritt 2: Danach stellen wir schon mal die Hosting-Einstellung ein. Wie hier im Beispiel: Hierbei erweitern wie den Dokumentstamm/Stammverzeichnis nur auf /public.

Schritt 3: Lade dann alle Files auf dem Webspace hoch und erstelle eine Datenbank. Sobald die Datenbank erstellt ist, logge dich über PhpMyAdmin ein und importiere die mitgelieferte .sql-Datei.

Schritt 4: Passe nun die .env (Konfigurationsdatei) an. Hierfür werden die Datenbankinformationen benötigt und die Seiten-URL. Bei der Seiten-URL ist dringend zu beachten, dass nach der URL ein Backslash sog. "/" eingetragen werden muss. Dann füge einen beliebigen Key für CRONE_KEY ein, für das Abfrufen des Cronjobs. Dieser Key, sollte nicht einfach aufrufbar sein. In diesem Beispiel verwenden wir: 123 als CRONE_KEY.

Schritt 5: Nun ist noch ein letzter Schritt notwendig. Un zwar muss man nun noch den PHP Composer nutzen. Hierfür musst Du nur auf die Domain bei Plesk drücken, dann auf PHP Composer und auf suchen drucken. Plesk sammelt nun alle Informationen. Sobald Plesk alle Informationen hat, muss nur noch auf Update (nicht Installieren) gedrückt werden. So steht es auch im Hinweis.

Schritt 6: Jetzt kannst Du dir einen Account anlegen und in der Datenbank den Status des Users auf 'active' und die Rolle des Users auf 'admin' stellen.

-- Hinweis --- Um die Erstellung vom Webspace, dem One-Click Installer, der Root-Server Installation (über VenoCIX-API) und der Gameserver zu ermöglichen - müssen noch mind. zwei Cronjobs erstellt werden.

Hierfür musst Du nur unter dem Tab "Geplante Aufgaben" in Plesk drücken und einen Cronjob anlegen.

Der erste Cronjob: -> Auswählen von URL-Abfrage -> Dann trägst Du in der URL, die Seiten-URL ein, die Du auch in der .env eingetragen hast. Nur mit /crone/worker_queue/123 -> Interval: * * * * *

Der zweite Cronjob: -> Auswahl von URL-Abfrage -> Genau die gleiche URL, nur mit /crone/runtime_queue/123 -> Interval * /10 * * *

Der dritte Cronjob ist leider Fehlerhaft. Trotz dessen nochmal erklärt. -> Auswahl von URL-Abfrage -> Das selbe, nur mit /crone/traffic_queue/123 -> Interval * * * * *

# Setup für Dedicated Server

1. Datenbank vorbereiten:


1.1 Die Tabelle `settings`um die spalten 'dedicated' TINYINT und 'dedi_costs' INT erweitern

1.2 Die Tabelle `dedicated` erstellen: CREATE TABLE `dedicated` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `price` double(12,2) NOT NULL,
  `custom_name` varchar(255) DEFAULT NULL,
  `locked` varchar(255) DEFAULT NULL,
  `state` varchar(255) NOT NULL DEFAULT 'order',
  `created_at` date NOT NULL DEFAULT current_timestamp(),
  `expire_at` date NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `days` int(11) NOT NULL DEFAULT 30
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

1.3 `id` als PrimaryKey setzten: ALTER TABLE `dedicated` ADD PRIMARY KEY (`id`);

1.4 `id` als Auto-Increment-Wert setzen: ALTER TABLE `dedicated` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27 ;





2. Dateien bearbeiten

2.1 Beigefügte Dateien hochladen

2.2 Datei /app/crone/worker_queue.php

2.2.1 direkt über "die(nothing todo)" folgende Zeile einfügen:

	include BASE_PATH . "app/crone/WORKER/dedicated_order.php";

2.3 Datei /app/functions/User.php

2.3.1 in die Methode getMonthlyCosts folgenden Block einkopieren:
	
	$SQL = self::db()->prepare("SELECT * FROM `dedicated` WHERE `user_id` = :user_id AND `deleted_at` IS NULL");
        $SQL->execute(array(":user_id" => $user_id));
        if ($SQL->rowCount() != 0) {
            while ($row = $SQL->fetch(PDO::FETCH_ASSOC)) {
                $costs = $costs + $row['price'];
            }
        }

2.4 Date /rescources/team/system.php

2.4.1 Im Kopf der Datei in den PHP-Code folgende 3 Blöcke einbauen:
	

	if(isset($_POST['activateDedicated'])){
	    $SQL = $db->prepare("UPDATE `settings` SET `dedicated` = '1'");
	    $SQL->execute();

	    echo sendSuccess('Dedicated Server wurden aktiviert');
	}
	if(isset($_POST['deactivateDedicated'])){
	    $SQL = $db->prepare("UPDATE `settings` SET `dedicated` = '0'");
	    $SQL->execute();
s
	    echo sendSuccess('Dedicated Server wurden deaktiviert');
	}
	if(isset($_POST['setDedicatedFees'])){
	    $SQL = $db->prepare("UPDATE `settings` SET `dedi_costs` = :fees");
	    $SQL->execute(array(":fees" => $_POST['dedicated_fees']));

	    echo sendSuccess('Die Zahlungsgebühren wurden gespeichert');
	}
	
2.4.2 Im Body an gewünschter Stelle (Reihenfolge der Blöcke) folgenden Block einsetzen:

	<div class="col-md-4">
            <div class="card card-custom card-stretch gutter-b">
                <div class="card-body d-flex flex-column">
                    <form method="post">
                        <label>Dedicated</label>
                        <br>
                        <br>
                        <?php if($helper->getSetting('dedicated') == 0){ ?>
                            <button type="submit" class="btn btn-outline-success btn-block btn-sm" name="activateDedicated"><b>Dedicated Server bestellung aktivieren</b></button>
                        <?php } else { ?>
                            <button type="submit" class="btn btn-outline-danger btn-block btn-sm" name="deactivateDedicated"><b>Dedicated Server bestellung deaktivieren</b></button>
                        <?php } ?>
                        <br>
                        <br>
                        <label>Kosten  <small>In %</small></label>
                        <input class="form-control" required type="number" name="dedicated_fees" value="<?= $helper->getSetting('dedi_costs'); ?>">
                        <small>Nur für neue Produkte gülltig!</small>
                        <br>
                        <button type="submit" class="btn btn-outline-warning btn-block btn-sm" name="setDedicatedFees"><b>Speichern</b></button>
                    </form>
                </div>
            </div>
        </div>

2.5 Datei .env

2.5.1 folgende Zeilen unten in der Datei einfügen:
	
	#Venocix
	VENOCIX_API_URL="https://reseller-sandbox.hosterapi.de/api/v1"
	VENOCIX_API_KEY="Uhkc6WIDHX86nON7q0gO2F1flKRcJvmyJflpefVW"
	
2.6 Datei /public/.htaccess

2.6.1 Folgende Zeilen in den <IfModule mod_rewrite.c> -Block einfügen:

    	#dedi
    	RewriteRule ^order/dedicated?$ index.php?page=order_dedicated_first [L]
    	RewriteRule ^order/dedicated/step/1?$ index.php?page=order_dedicated_first [L]
    	RewriteRule ^order/dedicated/step/2?$ index.php?page=order_dedicated_second [L]
    	RewriteRule ^manage/dedicated?$ index.php?page=manage_dedicated [L]
    	RewriteRule ^manage/dedicated/([A-Za-z0-9-]+)?$ index.php?page=manage_dedi&id=$1 [L]
    	RewriteRule ^renew/dedicated/([A-Za-z0-9-]+)?$ index.php?page=renew_dedicated&id=$1 [L]
    	
2.7 Datei /router/app.php

2.7.1 In den Switch-Case-Block folgende Zeilen einkopieren:

      	//dedicated
      	case "order_dedicated_first": include ($customer . "dedicated/order/first.php"); break;
      	case "order_dedicated_second": include ($customer . "dedicated/order/second.php"); break;
      	case "manage_dedicated": include ($customer . "dedicated/index.php"); break;
      	case "manage_dedi": include ($customer . "dedicated/manage.php"); break;
      	case "renew_dedicated": include ($customer . "dedicated/renew.php"); break;


Ich hoffe, dass dir die Hilfe helfen konnte.

Für Fragen stehen wir Ihnen gerne zur Verfügung.
	
# Was ist als nächstes geplant?

- Integration von Cloud vServern von Hetzner Online GmbH
- Installer für Gameserver, Webserver etc. via Net/SSH2
- Integration von weitere Zahlungs-Modulen
- Integration von News-System
- Integration von Partner-System
