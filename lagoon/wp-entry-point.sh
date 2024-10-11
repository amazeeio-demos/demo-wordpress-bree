#!/bin/sh

if [ -z "$HTTP_HOST" ]; then
	export HTTP_HOST=$LAGOON_ROUTE
fi
