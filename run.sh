docker compose up setup
docker compose -f docker-compose.yml -f extensions/filebeat/filebeat-compose.yml up -d --force-recreate