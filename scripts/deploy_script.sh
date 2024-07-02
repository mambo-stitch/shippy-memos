#!/bin/bash

echo "Pulling the latest Docker image..."
docker pull mambostitch/mambo-stitch:${CIRCLE_SHA1}

echo "Stopping existing Docker containers..."
# Using specific tag to stop containers
docker stop $(docker ps -q --filter "ancestor=mambostitch/mambo-stitch:${CIRCLE_SHA1}")

echo "Removing stopped containers..."
# Using specific tag to remove containers
docker rm $(docker ps -a -q --filter "ancestor=mambostitch/mambo-stitch:${CIRCLE_SHA1}")

# Check for running containers and stop them if any
containers_to_stop=$(docker ps -q --filter "ancestor=mambostitch/mambo-stitch:${CIRCLE_SHA1}")
if [ ! -z "$containers_to_stop" ]; then
    docker stop $containers_to_stop
    docker rm $containers_to_stop
else
    echo "No containers to stop."
fi

# Start the new container
docker run -d -p 80:80 --name mambo-stitch mambostitch/mambo-stitch:${CIRCLE_SHA1}

echo "Shippy complete!"