#!/bin/bash

PROJECT_ROOT="/mnt/e/disaster-recovery-automation-java"
APP_DIR="$PROJECT_ROOT/app"
LOG_FILE="$PROJECT_ROOT/bootstrap.log"

echo "🚀 Starting Disaster Recovery Automation Setup" | tee -a "$LOG_FILE"

# 1. Build Docker image
echo "🔨 Building Docker image..." | tee -a "$LOG_FILE"
cd "$APP_DIR" || exit 1
docker build -t dr-app . >> "$LOG_FILE" 2>&1

# 2. Remove old container if exists
echo "🧹 Cleaning old containers..." | tee -a "$LOG_FILE"
docker rm -f dr-app-container >> "$LOG_FILE" 2>&1 || true

# 3. Start container
echo "▶️ Starting application container..." | tee -a "$LOG_FILE"
docker run -d -p 8080:8080 --name dr-app-container dr-app >> "$LOG_FILE" 2>&1

# 4. Enable cron-based DR
echo "⏱️ Configuring cron-based recovery..." | tee -a "$LOG_FILE"
(crontab -l 2>/dev/null | grep -v recover.sh; \
echo "*/1 * * * * $PROJECT_ROOT/scripts/recover.sh >> $PROJECT_ROOT/cron.log 2>&1") | crontab -

# 5. Take initial backup
echo "💾 Taking initial backup..." | tee -a "$LOG_FILE"
"$PROJECT_ROOT/scripts/backup.sh" >> "$LOG_FILE" 2>&1

# 6. Health verification
echo "🔍 Verifying health..." | tee -a "$LOG_FILE"
sleep 10
curl -s http://localhost:8080/actuator/health | tee -a "$LOG_FILE"

echo "✅ Disaster Recovery Automation is ACTIVE" | tee -a "$LOG_FILE"
