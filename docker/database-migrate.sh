#!/bin/sh

# Database Connection
export DATABASE="mysql://root@127.0.0.1:3309/${PLANETSCALE_DATABASE_NAME}"

# Name
export PLANETSCALE_BRANCH_DATE=$(date '+%Y%m%d%H%M%S')
export PLANETSCALE_BRANCH_NAME_MIGRATE="${PLANETSCALE_BRANCH_DATE}-${PLANETSCALE_BRANCH_SUFFIX_MIGRATE}"

# Create Migration Branches
pscale branch create $PLANETSCALE_DATABASE_NAME $PLANETSCALE_BRANCH_NAME_MIGRATE \
--org $PLANETSCALE_ORG_NAME \
--service-token $PLANETSCALE_SERVICE_TOKEN \
--service-token-name $PLANETSCALE_SERVICE_TOKEN_NAME \
--from $PLANETSCALE_BRANCH_UPSTREAM

# Breathing Room
sleep 10

# Create Connections & Migrate
pscale connect $PLANETSCALE_DATABASE_NAME $PLANETSCALE_BRANCH_NAME_MIGRATE --port 3309 \
--org $PLANETSCALE_ORG_NAME \
--service-token $PLANETSCALE_SERVICE_TOKEN \
--service-token-name $PLANETSCALE_SERVICE_TOKEN_NAME \
--execute 'npx prisma migrate deploy'

# Open Deploy Request (Doesn't appear to work yet)
# pscale deploy-request create $PLANETSCALE_DATABASE_NAME $PLANETSCALE_BRANCH_NAME_MIGRATE \
# --deploy-to $PLANETSCALE_BRANCH_UPSTREAM \
# --org $PLANETSCALE_ORG_NAME \
# --service-token $PLANETSCALE_SERVICE_TOKEN \
# --service-token-name $PLANETSCALE_SERVICE_TOKEN_NAME
