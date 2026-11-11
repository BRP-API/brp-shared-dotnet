#!/bin/bash

MODE=$1

# pgadmin (profile 'tools') alleen lokaal starten, niet in de CI
if [[ "$MODE" = "ci" ]]; then PROFILE_ARGS=(); else PROFILE_ARGS=(--profile tools); fi

docker compose \
    -f .docker/db.yml \
    -f .docker/keycloak.yml \
    -f .docker/referentie-api.yml \
    -f .docker/autorisatie-protocollering-proxy.yml \
    "${PROFILE_ARGS[@]}" \
    up -d
