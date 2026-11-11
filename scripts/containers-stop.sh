#!/bin/bash

# --profile tools zodat pgadmin ook wordt gestopt wanneer deze lokaal is gestart
docker compose \
    -f .docker/db.yml \
    -f .docker/keycloak.yml \
    -f .docker/referentie-api.yml \
    -f .docker/autorisatie-protocollering-proxy.yml \
    --profile tools \
    down
