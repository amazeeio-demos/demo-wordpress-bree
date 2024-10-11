#!/bin/sh

cd /app/web
wp core is-installed --allow-root

# Get the return value from the above
WP_INSTALLED=$? 


if [ $WP_INSTALLED -ne 0 ]; then
  echo "Installing WordPress"

  cd /app/web

  wp core install \
    --url=$LAGOON_ROUTE \
    --title="amazee.io wordpress-example - $LAGOON_GIT_BRANCH" \
    --admin_user=admin \
    --admin_email=admin@example.com \
    --skip-email \
    --allow-root
else
  echo "WordPress is installed"
fi
