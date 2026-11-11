#!/bin/sh
# PlantCraft platform on Railway: map Railway's PORT/domain onto PlantCraft's settings, hand the generated
# admin password to the app as the password file it expects, fix volume ownership, drop to uid 10001.
set -e
export PLANTCRAFT_PORT="${PORT:-8060}"
export PLANTCRAFT_HOSTNAME="${PLANTCRAFT_HOSTNAME:-${RAILWAY_PUBLIC_DOMAIN:-localhost}}"
mkdir -p /data /run/plantcraft
if [ -n "$PLANTCRAFT_ADMIN_PASSWORD" ]; then
  umask 077
  printf '%s' "$PLANTCRAFT_ADMIN_PASSWORD" > /run/plantcraft/admin_password
  export PLANTCRAFT_BASIC_AUTH_PASSWORD_FILE=/run/plantcraft/admin_password
fi
unset PLANTCRAFT_ADMIN_PASSWORD
chown -R 10001:10001 /data /run/plantcraft
chmod 0750 /data
exec setpriv --reuid=10001 --regid=10001 --clear-groups python -m plantcraft.api.serve
