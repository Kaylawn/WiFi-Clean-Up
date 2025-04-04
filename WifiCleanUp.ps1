Write-host "Before Wifi clean up ..."
netsh.exe wlan show profiles
$list=(netsh.exe wlan show profiles) -match ':'
$ListOfSSID = ($list | Select-string -pattern "\w*All User Profile.*: (.*)" -allmatches).Matches | ForEach-Object {$_.Groups[1].Value}
$CurrentSSID = (get-netconnectionProfile).Name

Write-host "Current Wifi conection: $CurrentSSID"

foreach ($SSID in $ListOfSSID) {
    if ($SSID -ne $CurrentSSID) {
	netsh wlan delete profile name=$SSID
    }
}

Write-host "After Wifi clean up ..."
netsh.exe wlan show profiles


