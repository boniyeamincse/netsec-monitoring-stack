.PHONY: up-core down-core logs-core ps-core up-flows down-flows logs-flows ps-flows up-ids down-ids logs-ids ps-ids up-soc down-soc logs-soc ps-soc up-ti down-ti logs-ti ps-ti ps logs restart-core restart-flows restart-ids restart-soc restart-ti

SHELL := /bin/bash
COMPOSE := docker compose

# -----------------------------
# Core (Wazuh, LibreNMS, NetBox, Oxidized)
# -----------------------------
up-core:
	$(COMPOSE) --env-file .env -f compose/docker-compose.core.yml up -d

down-core:
	$(COMPOSE) -f compose/docker-compose.core.yml down

logs-core:
	$(COMPOSE) -f compose/docker-compose.core.yml logs -f

ps-core:
	$(COMPOSE) -f compose/docker-compose.core.yml ps

# -----------------------------
# Flows (nProbe + ntopng)
# -----------------------------
up-flows:
	$(COMPOSE) --env-file .env -f compose/docker-compose.flows.yml up -d

down-flows:
	$(COMPOSE) -f compose/docker-compose.flows.yml down

logs-flows:
	$(COMPOSE) -f compose/docker-compose.flows.yml logs -f

ps-flows:
	$(COMPOSE) -f compose/docker-compose.flows.yml ps

# -----------------------------
# IDS (Suricata + Zeek)
# -----------------------------
up-ids:
	$(COMPOSE) --env-file .env -f compose/docker-compose.ids.yml up -d

down-ids:
	$(COMPOSE) -f compose/docker-compose.ids.yml down

logs-ids:
	$(COMPOSE) -f compose/docker-compose.ids.yml logs -f

ps-ids:
	$(COMPOSE) -f compose/docker-compose.ids.yml ps

# -----------------------------
# SOC (TheHive + Cortex)
# -----------------------------
up-soc:
	$(COMPOSE) --env-file .env -f compose/docker-compose.soc.yml up -d

down-soc:
	$(COMPOSE) -f compose/docker-compose.soc.yml down

logs-soc:
	$(COMPOSE) -f compose/docker-compose.soc.yml logs -f

ps-soc:
	$(COMPOSE) -f compose/docker-compose.soc.yml ps

# -----------------------------
# Threat Intel (MISP)
# -----------------------------
up-ti:
	$(COMPOSE) --env-file .env -f compose/docker-compose.ti.yml up -d

down-ti:
	$(COMPOSE) -f compose/docker-compose.ti.yml down

logs-ti:
	$(COMPOSE) -f compose/docker-compose.ti.yml logs -f

ps-ti:
	$(COMPOSE) -f compose/docker-compose.ti.yml ps

# -----------------------------
# Grafana
# -----------------------------
up-grafana:
	$(COMPOSE) --env-file .env -f compose/docker-compose.grafana.yml up -d

down-grafana:
	$(COMPOSE) -f compose/docker-compose.grafana.yml down

logs-grafana:
	$(COMPOSE) -f compose/docker-compose.grafana.yml logs -f

ps-grafana:
	$(COMPOSE) -f compose/docker-compose.grafana.yml ps

# -----------------------------
# Utility
# -----------------------------
ps:
	$(COMPOSE) ps

logs:
	$(COMPOSE) logs -f

restart-core: down-core up-core
restart-flows: down-flows up-flows
restart-ids: down-ids up-ids
restart-soc: down-soc up-soc
restart-ti: down-ti up-ti
restart-grafana: down-grafana up-grafana