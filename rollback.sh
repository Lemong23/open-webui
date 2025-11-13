#!/bin/bash

set -e

backup_tag=$1

if [ -z "$backup_tag" ]; then
    echo "❌ Error: Backup tag required"
    echo ""
    echo "Usage: ./rollback.sh <backup-tag>"
    echo ""
    echo "Available backup images:"
    docker images open-webui --format "table {{.Repository}}:{{.Tag}}\t{{.CreatedAt}}" | grep backup
    exit 1
fi

echo "🔄 Rolling back to $backup_tag..."

# 현재 컨테이너 중지 및 삭제
docker stop open-webui 2>/dev/null || true
docker rm open-webui 2>/dev/null || true

# 백업 이미지로 컨테이너 실행
docker run --env-file .env -d -p 3000:8080 \
    --add-host=host.docker.internal:host-gateway \
    --gpus all \
    -v open-webui:/app/backend/data \
    --name open-webui \
    --restart always \
    open-webui:${backup_tag}

echo ""
echo "✅ Rollback complete!"
echo "📦 Running on image: open-webui:${backup_tag}"
