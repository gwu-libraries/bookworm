#!/bin/bash

# Change directory to the bookworm folder
cd /opt/bookworm
# Stash any local changes
git stash
# Checkout main branch if not already on it
git checkout main
# Pull any changes
git pull
# Stop and remove containers
docker compose down
# Remove locally built images
echo "Deleting locally built Docker images"
docker image rm $(docker images "bookworm-**" -q)
# Delete app volume
echo "Deleting app volume"
# Build containers
echo "Building docker images"
docker compose build
# Restart containers
echo "Restarting Docker containers"
docker compose up -d
# Run Database migrations if necessary
echo "Running Database Migrations"
docker exec -i $(docker ps --filter name=rails -q) bash -lc "bundle exec rails db:migrate RAILS_ENV=production"