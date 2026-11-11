# PlantCraft platform (Apache-2.0) on Railway. Base = upstream's own Dockerfile built unmodified at tag v0.6.1
# (commit 527e7c4) by .github/workflows/publish-ghcr.yml -> ghcr.io/onepush-dev/plantcraft-base:0.6.1.
# This layer only adds a start script: PORT/domain mapping, admin password file, volume ownership.
ARG BASE=ghcr.io/onepush-dev/plantcraft-base:0.6.1
FROM ${BASE}
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/plantcraft"
USER root
ENV PLANTCRAFT_BASIC_AUTH_ENABLED=true \
    PLANTCRAFT_BASIC_AUTH_USERNAME=admin \
    PLANTCRAFT_SESSION_HTTPS_ONLY=true \
    PLANTCRAFT_HTTPS_PORT=443 \
    PLANTCRAFT_APP_INSTALL=off \
    PLANTCRAFT_DEMO_USERS=false \
    PLANTCRAFT_LANGUAGE=en \
    PLANTCRAFT_TIMEZONE=UTC \
    PLANTCRAFT_LOG_LEVEL=INFO \
    PLANTCRAFT_WORKERS=auto \
    PLANTCRAFT_SCENARIO=/app/deploy/site/site.json \
    FORWARDED_ALLOW_IPS=* \
    SQLITE_TMPDIR=/data \
    PORT=8080
COPY railway-start.sh /usr/local/bin/railway-start.sh
RUN chmod 0755 /usr/local/bin/railway-start.sh
EXPOSE 8080
HEALTHCHECK NONE
CMD ["/usr/local/bin/railway-start.sh"]
