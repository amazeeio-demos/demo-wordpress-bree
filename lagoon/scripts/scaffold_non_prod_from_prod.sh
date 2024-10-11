#!/bin/sh

cd /app/web
wp core is-installed --allow-root

# Get the return value from the above
WP_INSTALLED=$?

if [ $WP_INSTALLED -ne 0 ]; then
  echo "Syncing the Main database for non-prod environment"
  cd /app
  lagoon-sync sync mariadb -p $LAGOON_PROJECT -e main -t "$LAGOON_GIT_BRANCH" --verbose --no-interaction
  lagoon-sync files mariadb -p $LAGOON_PROJECT -e main -t "$LAGOON_GIT_BRANCH" --verbose --no-interaction
else
  echo "WordPress is installed"
fi
