<?php

$hosterAPIDedi = new HosterAPI_Dedi();
class HosterAPI_Dedi extends Controller
{

    public function getClient() : \GuzzleHttp\Client
    {
        return new \GuzzleHttp\Client([
            'allow_redirects' => false,
            'timeout' => 5,
            'headers' => [
                'Content-Type' => 'application/json',
            ]
        ]);
    }



    public function getAvailable()
    {

        $client = new \GuzzleHttp\Client();
        $response = $client->get(
            ''. env('VENOCIX_API_URL').'/datacenter/dedicated/market',

            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer ' . env('VENOCIX_API_KEY'),
                ],
            ]
        );

        return json_decode((string)$response->getBody());
    }

    public function getTemplates()
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->get(
            ''. env('VENOCIX_API_URL').'/datacenter/dedicated/templates',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer '.env('VENOCIX_API_KEY'),
                ],
            ]
        );
        return json_decode((string) $response->getBody());
    }

    public function orderServer($id, $template, $ips, $hostname)
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->post(
            ''. env('VENOCIX_API_URL').'/datacenter/dedicated/order',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer '.env('VENOCIX_API_KEY'),
                ],
                'json' => [
                    'id' => $id,
                    'template' => $template,
                    'ipCount' => $ips,
                    'hostname' => $hostname,
                ],
            ]
        );
        return json_decode((string) $response->getBody());
    }

    public function deleteServer($id)
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->post(
            ''. env('VENOCIX_API_URL').'/datacenter/dedicated/' . $id . '/terminate',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer '.env('VENOCIX_API_KEY'),
                ]
            ]
        );
        return json_decode((string) $response->getBody());
    }

    public function getAll()
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->get(
            ''. env('VENOCIX_API_URL').'/datacenter/dedicated/',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer '.env('VENOCIX_API_KEY'),
                ]
            ]
        );
        return json_decode((string) $response->getBody());
    }

    public function getStatus($sid)
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->get(
            ''. env('VENOCIX_API_URL').'/datacenter/dedicated/'.$sid.'/status',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer '.env('VENOCIX_API_KEY'),
                ]
            ]
        );
        return json_decode((string) $response->getBody());
    }

    public function getConfig($sid)
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->get(
            ''. env('VENOCIX_API_URL').'/datacenter/dedicated/'.$sid.'/config',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer '.env('VENOCIX_API_KEY'),
                ]
            ]
        );
        return json_decode((string) $response->getBody());
    }

    public function start($sid)
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->put(
            ''. env('VENOCIX_API_URL').'/datacenter/dedicated/'.$sid.'/start',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer '.env('VENOCIX_API_KEY'),
                ],
            ]
        );
        $body = $response->getBody();
        return json_decode((string) $body);
    }

    public function stop($sid)
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->put(
            ''. env('VENOCIX_API_URL').'/datacenter/dedicated/'.$sid.'/shutdown',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer '.env('VENOCIX_API_KEY'),
                ],
            ]
        );
        $body = $response->getBody();
        return json_decode((string) $body);
    }

    public function reboot($sid)
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->put(
            ''. env('VENOCIX_API_URL').'/datacenter/dedicated/'.$sid.'/reboot',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer '.env('VENOCIX_API_KEY'),
                ],
            ]
        );
        $body = $response->getBody();
        return json_decode((string) $body);
    }

    public function reinstall($sid, $template, $hostname)
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->put(
            'https://reseller-sandbox.hosterapi.de/api/v1/datacenter/dedicated/'.$sid.'/reinstall',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer '.env('VENOCIX_API_KEY'),
                ],
                'json' => [
                    'template' => $template,
                    'hostname' => $hostname,
                ],
            ]
        );
        $body = $response->getBody();
       return json_decode((string) $body);
    }

    public function installSoftware($ip, $password, $package)
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->post(
            ''. env('VENOCIX_API_URL').'/software/install',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer ' . env('VENOCIX_API_KEY'),
                ],
                'json' => [
                    'ip' => $ip,
                    'package' => $package,
                    'password' => $password,
                    'port' => 22,
                ],
            ]
        );
        $body = $response->getBody();
        return (json_decode((string) $body));
    }

    public function uninstallSoftware($ip, $password, $package)
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->post(
            ''. env('VENOCIX_API_URL').'/software/uninstall',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer ' . env('VENOCIX_API_KEY'),
                ],
                'json' => [
                    'ip' => $ip,
                    'package' => $package,
                    'password' => $password,
                    'port' => 22,
                ],
            ]
        );
        $body = $response->getBody();
        return (json_decode((string) $body));
    }

    public function getVNC($sid)
    {
        $client = new \GuzzleHttp\Client();
        $response = $client->get(
            'https://reseller-sandbox.hosterapi.de/api/v1/datacenter/dedicated/' . $sid . '/console',
            [
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer ' . env('VENOCIX_API_KEY'),
                ],
            ]
        );
        $body = $response->getBody();
        return json_decode((string)$body);
    }
}