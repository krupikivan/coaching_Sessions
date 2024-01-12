echo "Stopping the project"
docker-compose stop
docker-compose down --volumes --remove-orphans
docker rm sessions-backend || true
docker rm sessions-db || true
docker rm sessions-web || true
echo "Starting the project"
docker-compose up -d --build