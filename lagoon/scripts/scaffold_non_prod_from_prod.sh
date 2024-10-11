#!/bin/sh

cd /app/web
wp core is-installed --allow-root

# Get the return value from the above
WP_INSTALLED=$?

if [ $WP_INSTALLED -ne 0 ]; then
  echo "Syncing the Main database for non-prod environment"
  lagoon-sync sync mariadb -p demo-bree-wordpress -e main -t "$LAGOON_GIT_BRANCH" --verbose -y
else
  echo "WordPress is installed"
fi
