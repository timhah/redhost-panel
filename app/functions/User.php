<?php

$user = new User();

class User extends Controller
{

    public function exists($data)
    {
        $SQL = self::db()->prepare("SELECT * FROM `users` WHERE `email` = :email OR `username` = :username");
        $SQL->execute(array(":email" => $data, ":username" => $data));
        if($SQL->rowCount() == 1){
            return true;
        } else {
            return false;
        }
    }

    public function getState($data)
    {
        $SQL = self::db()->prepare("SELECT * FROM `users` WHERE `email` = :email OR `username` = :username");
        $SQL->execute(array(":email" => $data, ":username" => $data));
        $data = $SQL->fetch(PDO::FETCH_ASSOC);

        return $data['state'];
    }

    public function getRole($data)
    {
        $SQL = self::db()->prepare("SELECT * FROM `users` WHERE `email` = :email OR `username` = :username");
        $SQL->execute(array(":email" => $data, ":username" => $data));
        $data = $SQL->fetch(PDO::FETCH_ASSOC);

        if($data['role'] == 'customer'){
            return 'Kunde';
        }

        if($data['role'] == 'support'){
            return 'Supporter';
        }

        if($data['role'] == 'admin'){
            return 'Administrator';
        }
    }

    public function verifyLogin($data, $password)
    {
        $SQL = self::db()->prepare('SELECT * FROM `users` WHERE `email` = :email OR `username` = :username');
        $SQL->execute(array(":email" => $data, ":username" => $data));
        $data = $SQL->fetch(PDO::FETCH_ASSOC);

        if(password_verify($password, $data['password'])) {
            return true;
        } else {
            return false;
        }
    }

    public function generateSessionToken($data)
    {
        $session_token = (new Helper)->generateRandomString(30);

        $SQL = self::db()->prepare("UPDATE `users` SET `session_token` = :session_token WHERE `email` = :email OR `username` = :username");
        $SQL->execute(array(":session_token" => $session_token, ":email" => $data, ":username" => $data));

        return $session_token;
    }

    public function create($username, $email, $password, $state = 'pending', $role = 'customer')
    {
        $cost = 10;
        $hash = password_hash($password, PASSWORD_BCRYPT, ['cost' => $cost]);

        $db = self::db();
        $SQL = $db->prepare("INSERT INTO `users`(`username`, `email`, `password`, `state`, `role`) VALUES (?,?,?,?,?)");
        $SQL->execute(array($username, $email, $hash, $state, $role));
        return $db->lastInsertId();
    }

    public function loggedIn($session_token = null)
    {
        if(is_null($session_token)){
            return false;
        } else {
            return $this->sessionExists($session_token);
        }
    }

    public function sessionExists($session_token)
    {
        $SQL = self::db()->prepare("SELECT * FROM `users` WHERE `session_token` = :session_token");
        $SQL->execute(array(":session_token" => $session_token));
        if($SQL->rowCount() == 1){
            return true;
        } else {
            return false;
        }
    }

    public function getDataBySession($session_token, $data)
    {
        $SQL = self::db()->prepare("SELECT * FROM `users` WHERE `session_token` = :session_token");
        $SQL->execute(array(":session_token" => $session_token));
        $response = $SQL->fetch(PDO::FETCH_ASSOC);

        return $response[$data];
    }

    public function getDataById($id, $data)
    {
        $SQL = self::db()->prepare("SELECT * FROM `users` WHERE `id` = :id");
        $SQL->execute(array(":id" => $id));
        $response = $SQL->fetch(PDO::FETCH_ASSOC);

        return $response[$data];
    }

    public function getDataByUsername($username, $data)
    {
        $SQL = self::db()->prepare("SELECT * FROM `users` WHERE `username` = :username");
        $SQL->execute(array(":username" => $username));
        $response = $SQL->fetch(PDO::FETCH_ASSOC);

        return $response[$data];
    }

    public function getDataByEmail($email, $data)
    {
        $SQL = self::db()->prepare("SELECT * FROM `users` WHERE `email` = :email");
        $SQL->execute(array(":email" => $email));
        $response = $SQL->fetch(PDO::FETCH_ASSOC);

        return $response[$data];
    }

    public function isInTeam($session_token)
    {
        $role = User::getDataBySession($session_token,'role');

        if($role == 'admin'){
            return true;
        } elseif($role == 'support'){
            return true;
        } else {
            return false;
        }
    }

    public function isAdmin($session_token)
    {
        $role = User::getDataBySession($session_token,'role');

        if($role == 'admin'){
            return true;
        } else {
            return false;
        }
    }

    public function getOS($user_agent)
    {
        $os_platform  = "Unbekannt";

        $os_array = array(
            '/windows nt 10/i'      =>  'Windows 10',
            '/windows nt 6.3/i'     =>  'Windows 8.1',
            '/windows nt 6.2/i'     =>  'Windows 8',
            '/windows nt 6.1/i'     =>  'Windows 7',
            '/windows nt 6.0/i'     =>  'Windows Vista',
            '/windows nt 5.2/i'     =>  'Windows Server 2003/XP x64',
            '/windows nt 5.1/i'     =>  'Windows XP',
            '/windows xp/i'         =>  'Windows XP',
            '/windows nt 5.0/i'     =>  'Windows 2000',
            '/windows me/i'         =>  'Windows ME',
            '/win98/i'              =>  'Windows 98',
            '/win95/i'              =>  'Windows 95',
            '/win16/i'              =>  'Windows 3.11',
            '/macintosh|mac os x/i' =>  'Mac OS X',
            '/mac_powerpc/i'        =>  'Mac OS 9',
            '/linux/i'              =>  'Linux',
            '/ubuntu/i'             =>  'Ubuntu',
            '/iphone/i'             =>  'iPhone',
            '/ipod/i'               =>  'iPod',
            '/ipad/i'               =>  'iPad',
            '/android/i'            =>  'Android',
            '/blackberry/i'         =>  'BlackBerry',
            '/webos/i'              =>  'Mobile'
        );

        foreach ($os_array as $regex => $value)
            if (preg_match($regex, $user_agent))
                $os_platform = $value;

        return $os_platform;
    }

    public function getBrowser($user_agent): string
    {
        $browser = "Unbekannt";

        $browser_array = array(
            '/msie/i'      => 'Internet Explorer',
            '/trident/i'   => 'Internet Explorer',
            '/edge/i'      => 'Microsoft Edge',
            '/firefox/i'   => 'Firefox',
            '/safari/i'    => 'Safari',
            '/chrome/i'    => 'Chrome',
            '/opera/i'     => 'Opera',
            '/netscape/i'  => 'Netscape',
            '/maxthon/i'   => 'Maxthon',
            '/konqueror/i' => 'Konqueror',
            '/mobile/i'    => 'Handy-Browser',
            '/brave/i'     => 'Brave',
            '/epiphany/i'  => 'Epiphany',
            '/ucbrowser/i' => 'UC Browser',
            '/yabrowser/i' => 'Yandex Browser',
            '/waterfox/i'  => 'Waterfox',
            '/sleipnir/i'  => 'Sleipnir',
            '/lunascape/i' => 'Lunascape',
            '/avant/i'     => 'Avant Browser',
            '/webpositive/i'=> 'WebPositive',
            '/aol/i'       => 'AOL Browser',
            '/k-meleon/i'  => 'K-Meleon',
            '/seamonkey/i' => 'SeaMonkey',
            '/galeon/i'    => 'Galeon',
            '/iron/i'      => 'SRWare Iron',
            '/comodo/i'    => 'Comodo Dragon',
            '/rockmelt/i'  => 'RockMelt',
            '/slimboat/i'  => 'SlimBrowser',
            '/flock/i'     => 'Flock',
            '/netsurf/i'   => 'NetSurf',
            '/epic/i'      => 'Epic Browser',
            '/dolphin/i'   => 'Dolphin',
            '/qupzilla/i'  => 'QupZilla',
            '/silk/i'      => 'Amazon Silk',
            '/otter/i'     => 'Otter Browser',
            '/gnome\-web/i'=> 'Epiphany (GNOME Web)',
            '/tizen/i'     => 'Tizen Browser',
            '/slimjet/i'   => 'Slimjet',
            '/cyberfox/i'  => 'Cyberfox',
            '/icedragon/i' => 'Comodo IceDragon',
            '/vivaldi/i'   => 'Vivaldi',
            '/coc_coc/i'   => 'Coc Coc',
            '/sogou/i'     => 'Sogou Browser',
            '/qihoo/i'     => '360 Secure Browser',
            '/huohou/i'    => 'Huohou Browser',
            '/miui/i'      => 'Mi Browser',
            '/huawei/i'    => 'Huawei Browser',
            '/oneplus/i'   => 'OnePlus Browser',
            '/meizu/i'     => 'Meizu Browser',
            '/nokia/i'     => 'Nokia Browser',
            '/lenovo/i'    => 'Lenovo Browser',
            '/zte/i'       => 'ZTE Browser',
            '/leeco/i'     => 'LeEco Browser',
            '/realme/i'    => 'Realme Browser',
            '/tecent/i'    => 'Tencent QQ Browser',
            '/baidu/i'     => 'Baidu Browser',
            '/vivo/i'      => 'Vivo Browser',
            '/mxios/i'     => 'Maxthon for iOS',
            '/baidubox/i'  => 'Baidu Box App',
            '/qqlive/i'    => 'Tencent QQ Live App',
            '/weibo/i'     => 'Sina Weibo App',
            '/wechat/i'    => 'WeChat App',
            '/alipay/i'    => 'Alipay Mini Program',
            '/taobao/i'    => 'Taobao Mini Program',
            '/palemoon/i'  => 'Pale Moon',
            '/odo/i'       => 'Opera Neon',
            '/midori/i'    => 'Midori',
            '/rekonq/i'    => 'Rekonq',
            '/uzbl/i'      => 'Uzbl',
            '/whale/i'     => 'Naver Whale',
            '/yandexsearch/i' => 'Yandex Search App',
            '/qqbrowser/i' => 'QQ Browser',
            '/baidubrowser/i' => 'Baidu Browser',
            '/liebaofast/i' => 'Liebao Browser (LBBrowser)',
            '/liebaomini/i' => 'Liebao Mini Browser',
            '/duckduckgo/i' => 'DuckDuckGo Browser',
            '/bb10/i'      => 'BlackBerry 10 Browser',
            '/edgeios/i'   => 'Microsoft Edge (iOS)',
            '/edgeandroid/i' => 'Microsoft Edge (Android)',
            '/focus/i'     => 'Firefox Focus',
            '/focusios/i'  => 'Firefox Focus (iOS)',
            '/adobeair/i'  => 'Adobe AIR Application',
            '/kindle/i'    => 'Amazon Kindle',
            '/iridium/i'   => 'Iridium Browser',
            '/vewd/i'      => 'Vewd (formerly Opera TV)',
            '/viera/i'     => 'Panasonic Viera TV Browser',
            '/snapchat/i'  => 'Snapchat App',
            '/puffin/i'    => 'Puffin Browser',
            '/webos/i'     => 'webOS Browser',
            '/maemo/i'     => 'Maemo Browser (Nokia N900)',
            '/meego/i'     => 'MeeGo Browser',
            '/wii/i'       => 'Nintendo Wii Browser',
            '/psp/i'       => 'PlayStation Portable Browser',
            '/camino/i'    => 'Camino',
            '/kazehakase/i'=> 'Kazehakase',
            '/gobrowser/i' => 'GO Browser',
            '/tor/i'       => 'TOR (The Onion Router)',
            // Browser, die von Regierungsbehörden oder militärischen Organisationen verwendet werden
            '/usgcb/i'     => 'U.S. Government Web Browser',
            '/qubes/i'     => 'Qubes OS Secure Browser',
            '/swb/i'       => 'Secure Web Browser (SWB)',
            '/iceweasel/i' => 'IceWeasel',
            '/gsb/i'       => 'Government Secure Browser (GSB)'
        );

        foreach ($browser_array as $regex => $value) {
            if (preg_match($regex, $user_agent)) {
                $browser = $value;
            }
        }

        return $browser;
    }

    public function getIP()
    {
        foreach (array('HTTP_CLIENT_IP', 'HTTP_X_FORWARDED_FOR', 'HTTP_X_FORWARDED', 'HTTP_X_CLUSTER_CLIENT_IP', 'HTTP_FORWARDED_FOR', 'HTTP_FORWARDED', 'REMOTE_ADDR') as $key){
            if (array_key_exists($key, $_SERVER) === true){
                foreach (explode(',', $_SERVER[$key]) as $ip){
                    $ip = trim($ip); // just to be safe

                    if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE) !== false){
                        return $ip;
                    }
                }
            }
        }
    }

    public function getAgent()
    {
        return $_SERVER['HTTP_USER_AGENT'];
    }

    public function addMoney($money, $user_id){
        $SQL = self::db()->prepare("SELECT * FROM `users` WHERE `id` = :id");
        $SQL->execute(array(':id' => $user_id));
        $userData = $SQL -> fetch(PDO::FETCH_ASSOC);

        $newUserMoney = $userData['amount'] + $money;
        $updateUserMoney = self::db()->prepare("UPDATE `users` SET `amount`=:newUserMoney WHERE `id` = :user_id");
        $updateUserMoney->execute(array(":newUserMoney" => $newUserMoney, ":user_id" => $user_id));
    }

    public function removeMoney($price, $user_id){
        $SQL = self::db()->prepare("SELECT * FROM `users` WHERE `id` = :id");
        $SQL->execute(array(':id' => $user_id));
        $userData = $SQL -> fetch(PDO::FETCH_ASSOC);

        $newUserMoney = $userData['amount'] - $price;
        $updateUserMoney = self::db()->prepare("UPDATE `users` SET `amount`=:newUserMoney WHERE `id` = :user_id");
        $updateUserMoney->execute(array(":newUserMoney" => $newUserMoney, ":user_id" => $user_id));
    }

    public function addTransaction($user_id, $amount, $desc){
        $SQL = self::db()->prepare("INSERT INTO `user_transactions`(`user_id`, `amount`, `desc`) VALUES (?,?,?)");
        $SQL->execute(array($user_id, $amount, $desc));
    }

    public function serviceCount($user_id)
    {
        $count = 0;

        $SQL = self::db()->prepare('SELECT * FROM `teamspeaks` WHERE `user_id` = :user_id AND `deleted_at` IS NULL');
        $SQL->execute(array(":user_id" => $user_id));
        $count = $count + $SQL->rowCount();

        $SQL = self::db()->prepare('SELECT * FROM `vm_servers` WHERE `user_id` = :user_id AND `deleted_at` IS NULL');
        $SQL->execute(array(":user_id" => $user_id));
        $count = $count + $SQL->rowCount();

        $SQL = self::db()->prepare('SELECT * FROM `webspace` WHERE `user_id` = :user_id AND `deleted_at` IS NULL');
        $SQL->execute(array(":user_id" => $user_id));
        $count = $count + $SQL->rowCount();

        return $count;
    }
    
    public function activeCount($user_id)
    {
        $count = 0;

        $SQL = self::db()->prepare("SELECT * FROM `teamspeaks` WHERE `user_id` = :user_id AND `deleted_at` IS NULL AND `state` = 'ACTIVE'");
        $SQL->execute(array(":user_id" => $user_id));
        $count = $count + $SQL->rowCount();

        $SQL = self::db()->prepare("SELECT * FROM `vm_servers` WHERE `user_id` = :user_id AND `deleted_at` IS NULL' AND `state` = 'active'");
        $SQL->execute(array(":user_id" => $user_id));
        $count = $count + $SQL->rowCount();

        $SQL = self::db()->prepare("SELECT * FROM `webspace` WHERE `user_id` = :user_id AND `deleted_at` IS NULL AND `state` = 'active'");
        $SQL->execute(array(":user_id" => $user_id));
        $count = $count + $SQL->rowCount();

        return $count;
    }

    public function teamspeakCount($user_id)
    {
        $SQL = self::db()->prepare('SELECT * FROM `teamspeaks` WHERE `user_id` = :user_id AND `deleted_at` IS NULL');
        $SQL->execute(array(":user_id" => $user_id));
        return $SQL->rowCount();
    }

    public function domainCount($user_id)
    {
        $SQL = self::db()->prepare('SELECT * FROM `domains` WHERE `user_id` = :user_id AND `deleted_at` IS NULL');
        $SQL->execute(array(":user_id" => $user_id));
        return $SQL->rowCount();
    }

    public function webspaceCount($user_id)
    {
        $SQL = self::db()->prepare('SELECT * FROM `webspace` WHERE `user_id` = :user_id AND `deleted_at` IS NULL');
        $SQL->execute(array(":user_id" => $user_id));
        return $SQL->rowCount();
    }

    public function getOpenTickets($user_id)
    {
        $SQL = self::db()->prepare('SELECT * FROM `tickets` WHERE `user_id` = :user_id AND `state` = :state');
        $SQL->execute(array(":user_id" => $user_id, ":state" => 'OPEN'));
        return $SQL->rowCount();
    }

    public function getMontlyCosts($user_id)
    {
        $costs = 0.00;

        $SQL = self::db()->prepare("SELECT * FROM `teamspeaks` WHERE `user_id` = :user_id AND `deleted_at` IS NULL");
        $SQL->execute(array(":user_id" => $user_id));
        if ($SQL->rowCount() != 0) {
            while ($row = $SQL->fetch(PDO::FETCH_ASSOC)) {
                $costs = $costs + ($row['slots'] * Site::getProductPrice('TEAMSPEAK'));
            }
        }

        $SQL = self::db()->prepare("SELECT * FROM `vm_servers` WHERE `user_id` = :user_id AND `deleted_at` IS NULL");
        $SQL->execute(array(":user_id" => $user_id));
        if ($SQL->rowCount() != 0) {
            while ($row = $SQL->fetch(PDO::FETCH_ASSOC)) {
                $costs = $costs + $row['price'];
            }
        }

        $SQL = self::db()->prepare("SELECT * FROM `webspace` WHERE `user_id` = :user_id AND `deleted_at` IS NULL");
        $SQL->execute(array(":user_id" => $user_id));
        if ($SQL->rowCount() != 0) {
            while ($row = $SQL->fetch(PDO::FETCH_ASSOC)) {
                $costs = $costs + $row['price'];
            }
        }

        return number_format($costs,2);
    }

    public function getDataByAffiliateId($id, $data)
    {
        $SQL = self::db()->prepare("SELECT * FROM `users` WHERE `affiliate_id` = :affiliate_id");
        $SQL->execute(array(":affiliate_id" => $id));
        $response = $SQL->fetch(PDO::FETCH_ASSOC);

        return $response[$data];
    }

    public function renewSupportPin($userid, $token = null)
    {
        if(is_null($token)){
            $token = (new Helper)->generateRandomString(5,'1234567890');
        }

        $SQL = self::db()->prepare("UPDATE `users` SET `s_pin` = :s_pin WHERE `id` = :id");
        $SQL->execute(array(":id" => $userid, ":s_pin" => $token));

        return $token;
    }

    public function validateSpin($s_pin)
    {
        $SQL = self::db()->prepare('SELECT * FROM `users` WHERE `s_pin` = :s_pin');
        $SQL->execute(array(":s_pin" => $s_pin,));
        if ($SQL->rowCount() == 1) {
            $userData = $SQL -> fetch(PDO::FETCH_ASSOC);
            return $userData['id'];
        } else {
            return 0;
        }
    }

    public function logLogin($user_id, $user_addr, $user_agent)
    {
        $SQL = self::db()->prepare("INSERT INTO `login_logs`(`user_id`, `user_addr`, `user_agent`) VALUES (?,?,?)");
        $SQL->execute(array($user_id, $user_addr, $user_agent));
    }

}
