#!/bin/bash

PROJECT_ROOT="/mnt/e/disaster-recovery-automation-java"
HEALTH_SCRIPT="$PROJECT_ROOT/scripts/health-check.sh"
LOG_FILE="$PROJECT_ROOT/cron.log"

echo "🔍 Running health check..." >> "$LOG_FILE"

if bash "$HEALTH_SCRIPT"; then
  echo "🟢 Application is HEALTHY" >> "$LOG_FILE"
  exit 0
fi

echo "❌ Application is DOWN" >> "$LOG_FILE"
echo "🚨 Failure detected. Starting recovery..." >> "$LOG_FILE"

docker rm -f dr-app-container >> "$LOG_FILE" 2>&1
docker run -d -p 8080:8080 --name dr-app-container dr-app >> "$LOG_FILE" 2>&1

echo "✅ Recovery completed" >> "$LOG_FILE"
