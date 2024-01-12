#!/bin/bash
echo "Running Rails migrations"
rm -f /sessions/tmp/pids/server.pid
bundle exec rake log db:migrate
echo "Starting Puma Server $(date +"%Y-%m-%d_%H-%M-%S")"
(cd sessions_backend/ && bundle exec rails s -u puma -b 0.0.0.0 -p $PORT)