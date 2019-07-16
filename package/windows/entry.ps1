# ENTRYPOINT
$winsPath = "c:\etc\wmi-exporter\wmi-exporter.exe"

# default
$listenPort = "9796"
$enabledCollectors = "net,os,service,system,cpu,cs,logical_disk"

if ($env:LISTEN_PORT) {
    $listenPort = $env:LISTEN_PORT
}

if ($env:ENABLED_COLLECTORS) {
    $enabledCollectors = $env:ENABLED_COLLECTORS
}

# format "UDP:4789 TCP:8080"
$winsExposes = $('TCP:{0}' -f $listenPort)

# format "--a=b --c=d"
$winsArgs = $('--collectors.enabled={0} --telemetry.addr=:{1}' -f $enabledCollectors, $listenPort)


wins.exe cli prc start --path $winsPath --exposes $winsExposes --args "$winsArgs"