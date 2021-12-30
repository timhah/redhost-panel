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

Ich hoffe, dass dir die Hilfe helfen konnte.

Für Fragen stehen wir Ihnen gerne zur Verfügung.
