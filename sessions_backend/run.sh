#!/bin/bash
echo "Running Rails migrations"
echo $(pwd)
echo $(ls -l)
rm -f /sessions/tmp/pids/server.pid
bundle exec rake log db:migrate
echo "Starting Puma Server $(date +"%Y-%m-%d_%H-%M-%S")"
bundle exec rails s -u puma -b 0.0.0.0 -p $PORT