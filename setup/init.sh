#!/usr/bin/env bash

elasticsearch_host="${ELASTICSEARCH_HOST:-elasticsearch}"

until curl -u elastic:"${ELASTIC_PASSWORD}" -sS "http://${elasticsearch_host}:9200/_cluster/health?wait_for_status=yellow&timeout=1m"; do
  sleep 1
done

curl -u elastic:"${ELASTIC_PASSWORD}" -X PUT "http://${elasticsearch_host}:9200/_ilm/policy/logstash_ilm_policy?pretty" \
  -H "Content-Type: application/json" \
  -d @/tmp/lifecycle_policy.json


curl  -u elastic:"${ELASTIC_PASSWORD}" -X PUT "http://${elasticsearch_host}:9200/_index_template/logs-app-prod" \
  -H "Content-Type: application/json" \
  -d @/tmp/logstash-template.json