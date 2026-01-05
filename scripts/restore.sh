#!/bin/bash

BACKUP_DIR="backups"

LATEST_BACKUP=$(ls -t $BACKUP_DIR/*.tar.gz | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
  echo "❌ No backup found"
  exit 1
fi

echo "♻️ Restoring from $LATEST_BACKUP"

gunzip -c $LATEST_BACKUP | docker load

echo "✅ Restore completed"
