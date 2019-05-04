#!/bin/bash

# Exit on fail
set -e

# Ensure all gems installed.
bundle check || bundle install

# Remove server.pid if it exists
if [ -f tmp/pids/server.pid ]; then
  rm -f tmp/pids/server.pid
fi

# Ensure migration is run & if no db create new
bundle exec rake db:migrate
if [[ $? != 0 ]]; then
  bundle exec rake db:setup
fi

# Finally call command issued to the docker service
exec "$@"
