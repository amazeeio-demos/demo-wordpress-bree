#!/bin/sh

echo "Loading lagoon environment entrypoint"

# Loading environment variables from .env and friends
source /lagoon/entrypoints/50-dotenv.sh

# Generate some additional enviornment variables
source /lagoon/entrypoints/55-generate-env.sh

echo "Done loading lagoon environment"

if [ -z "$HTTP_HOST" ]; then
	export HTTP_HOST=$LAGOON_ROUTE
fi
