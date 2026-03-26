#!/bin/bash
# Serve Flutter web build on port 7777
cd /root/.openclaw/workspace/mmas-money-tracker/build/web
exec python3 -m http.server 7777 --bind 0.0.0.0
