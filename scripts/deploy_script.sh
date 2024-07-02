#!/bin/bash

echo "Pulling the latest Docker image..."
docker pull mambostitch/mambo-stitch:${CIRCLE_SHA1}

echo "Checking for existing containers to stop..."
containers_to_stop=$(docker ps -q --filter "ancestor=mambostitch/mambo-stitch:${CIRCLE_SHA1}")
if [ ! -z "$containers_to_stop" ]; then
    echo "Stopping containers: $containers_to_stop"
    docker stop $containers_to_stop
    echo "Removing containers: $containers_to_stop"
    docker rm $containers_to_stop
else
    echo "No existing containers to stop."
fi

echo "Starting new Docker container..."
docker run -d -p 80:80 --name mambo-stitch mambostitch/mambo-stitch:${CIRCLE_SHA1}

echo "Deployment complete."