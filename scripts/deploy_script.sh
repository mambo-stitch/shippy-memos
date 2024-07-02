#!/bin/bash

# Stop all running containers (simplified approach for demonstration purposes)
docker stop $(docker ps -aq)

# Remove all stopped containers
docker rm $(docker ps -aq)

# Pull the latest image from Docker Hub
docker pull mambostitch/mambo-stitch:${CIRCLE_SHA1}

# Start the new container
docker run -d -p 80:80 mambostitch/mambo-stitch:${CIRCLE_SHA1}