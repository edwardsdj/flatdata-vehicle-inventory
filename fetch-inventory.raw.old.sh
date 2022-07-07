#!/usr/bin/env bash

rm inventory.json
IFS=', ' read -r -a array < dealers.txt
max_count=10000 

for i in ${array[@]:0:max_count}

do
curl \
  --header "Content-Type: application/json" \
  --request POST \
  --data '{
      "brand": "TOY",
      "mode": "content",
      "group": true,
      "groupmode": "full",
      "relevancy": false,
      "pagesize": 300,
      "pagestart": 0,
      "filter": {
          "year": [2021, 2022], 
          "series": ["sienna"], 
          "dealers": ["'$i'"]
        }
    }' \
  https://www.toyota.com/config/services/inventory/search/getInventory | jq '.' >> raw.jsonl
done

cat raw.jsonl | jq -s '.' > raw.json | jq -s '.' > inventory.json 
rm raw.jsonl