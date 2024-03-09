#!/bin/sh

btcusd_price=$(curl -s "https://api.gemini.com/v1/pricefeed" | jq -r '.[] | select(.pair=="BTCUSD") | .price')
sketchybar -m --set btc label=$btcusd_price
