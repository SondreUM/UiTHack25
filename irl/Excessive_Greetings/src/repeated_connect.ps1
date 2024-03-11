for($x=0;$x -lt 4;$x++){
    if ($x % 2 -eq 0) {
        netsh wlan connect ssid=Piratecove name=Piratecove interface=Wi-Fi
    }
    else {
        netsh wlan disconnect interface=Wi-Fi
    }
    Start-Sleep -Seconds 5
}