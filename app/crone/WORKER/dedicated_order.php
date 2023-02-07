<?php
foreach ($hosterAPIDedi->getAll()->result as $dedi)
{
    $id = $dedi->id;
    $state = $dedi->orderComplete;

    if($state){
        $SQL = $db->prepare("SELECT * FROM dedicated WHERE server_id = :sid AND state = :state");
        $SQL->execute(array(":sid" => $id, ":state" => "order"));
        if($SQL->rowCount() != 0) {
            while ($row = $SQL->fetch(PDO::FETCH_ASSOC)) {
                $SQL2 = $db->prepare("UPDATE dedicated SET state = :state WHERE id = :id");
                $SQL2->execute(array(":state" => "active", ":id" => $row['id']));
                echo("Activated Dedicated Server ".$row->id." (".$id.") <br>");
            }
        }
    }
}