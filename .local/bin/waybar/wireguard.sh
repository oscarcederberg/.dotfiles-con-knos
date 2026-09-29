#!/usr/bin/env bash

STATUS_CONNECTED_STR='{"text":"Connected","class":"connected","alt":"connected"}'
STATUS_DISCONNECTED_STR='{"text":"Disconnected","class":"disconnected","alt":"disconnected"}'

function status_wireguard() {
    nmcli connection show --active | grep -q '^wg0[[:space:]]'
    return $?
}

function toggle_wireguard() {
    status_wireguard && \
        nmcli connection down wg0 || \
        nmcli connection up wg0
}

case $1 in
    -s | --status)
        status_wireguard && echo $STATUS_CONNECTED_STR || echo $STATUS_DISCONNECTED_STR
        ;;
    -t | --toggle)
        toggle_wireguard
        ;;
esac
