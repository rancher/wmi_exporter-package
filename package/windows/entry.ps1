# ENTRYPOINT
$winsPath = "c:\etc\wmi-exporter\wmi-exporter.exe"

# default
$listenPort = "9796"
$enabledCollectors = "net,os,service,system,cpu,cs,logical_disk"
$maxRequests = "5"

if ($env:LISTEN_PORT) {
    $listenPort = $env:LISTEN_PORT
}

if ($env:ENABLED_COLLECTORS) {
    $enabledCollectors = $env:ENABLED_COLLECTORS
}

if ($env:MAX_REQUESTS) {
    $maxRequests = $env:MAX_REQUESTS
}

# format "UDP:4789 TCP:8080"
$winsExposes = $('TCP:{0}' -f $listenPort)

# format "--a=b --c=d"
$winsArgs = $('--collectors.enabled={0} --telemetry.addr=:{1} --telemetry.max-requests={2} --telemetry.path=/metrics' -f $enabledCollectors, $listenPort, $maxRequests)


wins.exe cli prc run --path $winsPath --exposes $winsExposes --args "$winsArgs"