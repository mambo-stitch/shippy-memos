#!/bin/bash

echo "Pulling the latest Docker image..."
docker pull mambostitch/mambo-stitch:${CIRCLE_SHA1}

echo "Stopping existing Docker containers..."
docker stop $(docker ps -q --filter ancestor=mambostitch/mambo-stitch)

echo "Removing stopped containers..."
docker rm $(docker ps -a -q --filter ancestor=mambostitch/mambo-stitch)

echo "Starting new Docker container..."
docker run -d -p 80:80 --name mambo-stitch mambostitch/mambo-stitch:${CIRCLE_SHA1}

echo "Deployment complete."