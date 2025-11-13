#!/bin/bash

set -e

image_name="open-webui"
container_name="open-webui"
timestamp=$(date +%Y%m%d-%H%M%S)

# 현재 이미지를 백업 태그로 저장
echo "Backing up current image..."
docker tag ${image_name}:latest ${image_name}:backup-${timestamp} 2>/dev/null || echo "No existing image to backup"

# 새 이미지 빌드
echo "Building new image..."
docker build -t ${image_name}:latest .

# 기존 컨테이너 중지
echo "Stopping current container..."
docker stop "$container_name" 2>/dev/null || true

# 기존 컨테이너 삭제
echo "Removing current container..."
docker rm "$container_name" 2>/dev/null || true

# 새 컨테이너 실행
echo "Starting new container..."
docker run --env-file .env -d -p 3000:8080 \
    --add-host=host.docker.internal:host-gateway \
    --gpus all \
    -v open-webui:/app/backend/data \
    --name "$container_name" \
    --restart always \
    ${image_name}:latest

echo ""
echo "✅ Deployed successfully!"
echo "📦 Backup image saved as: ${image_name}:backup-${timestamp}"
echo ""
echo "To rollback if there's an issue:"
echo "  ./rollback.sh backup-${timestamp}"
