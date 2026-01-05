#!/bin/bash

BACKUP_DIR="backups"
IMAGE_NAME="dr-app"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

echo "📦 Creating backup..."
docker save $IMAGE_NAME | gzip > $BACKUP_DIR/dr-app-$TIMESTAMP.tar.gz

echo "✅ Backup saved as $BACKUP_DIR/dr-app-$TIMESTAMP.tar.gz"
