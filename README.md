# Process engineering suite (based on PlantCraft) — historian-ready platform for process engineers. Deploy on Railway with one click.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/deploy/vz-0_y)

This template runs the [PlantCraft](https://github.com/PlantCraft/PlantCraft) platform (Apache-2.0), built unmodified
from upstream tag v0.6.1 with upstream's own Dockerfile (`ghcr.io/onepush-dev/plantcraft-base:0.6.1`), plus a small
Railway start script (`ghcr.io/onepush-dev/plantcraft:0.6.1`). It is a community deployment based on PlantCraft, not an
official PlantCraft bundle (see upstream TRADEMARKS.md).

## What the template sets up
- One service `plantcraft` (the central application: people and access, assets and signals, Desk, Notebooks,
  assistant, API v1, MCP), health check `/healthz`, SQLite + session key on a volume at `/data`
- Sign-in on by default: user `admin`, password = generated `PLANTCRAFT_ADMIN_PASSWORD` (service Variables tab)
- HTTPS-only session cookies behind Railway's edge; `PLANTCRAFT_HOSTNAME` follows the Railway domain

## Not included (and why)
Upstream's offline compose also runs a Caddy TLS proxy (Railway's edge does TLS), the Docker-socket app
installer (not possible on Railway, so `PLANTCRAFT_APP_INSTALL=off`), an LLM egress allow-list proxy and a
compute gateway (both exchange files with the platform through shared host folders, which Railway services
cannot share), and the optional profile apps (Historian + PostgreSQL, Analytics, View, Alarms, Models,
Documents, Simulator). Without the egress proxy, language-model calls go straight to the provider an
administrator configures in Setup (no model is called until then).
