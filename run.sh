#!/bin/bash

image_name="open-webui"
container_name="open-webui"
host_port=3000
container_port=8080

docker stop "$container_name" &>/dev/null || true
#docker rm "$container_name" &>/dev/null || true
#docker build -t "$image_name" .

docker run --env-file .env -d -p "$host_port":"$container_port" \
    --add-host=host.docker.internal:host-gateway \
    --gpus all \
    -v "${image_name}:/app/backend/data" \
    --name "$container_name" \
    --restart always \
    "$image_name" 

docker image prune -f
