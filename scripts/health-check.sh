#!/bin/bash

URL="http://localhost:8080/actuator/health"

if curl -s "$URL" | grep -q UP; then
  exit 0
else
  exit 1
fi
