#!/bin/bash

while true; do
  quantity=$((1 + RANDOM % 20))
  curl_cmd="curl -X POST http://localhost:50050/shop/order -H 'Content-Type: application/json' -d '{\"styleName\": \"beachops\", \"quantity\": '$quantity'}'"
  echo $curl_cmd
  eval $curl_cmd
  sleep ${1:-1}
  echo
done
