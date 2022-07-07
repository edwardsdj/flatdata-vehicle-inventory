#!/usr/bin/env bash

rm inventory.json
IFS=', ' read -r -a array < dealers.txt

for i in ${array[@]}
do
  curl https://www.toyota.com/config/services/inventory/search/getInventory | jq '.[:6]' raw.jsonl
done

cat raw.jsonl | jq -s '.' > raw.json
rm raw.jsonl
