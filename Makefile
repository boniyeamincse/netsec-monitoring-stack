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

health-core:
	@docker compose -f compose/docker-compose.core.yml ps
health-flows:
	@docker compose -f compose/docker-compose.flows.yml ps
health-ids:
	@docker compose -f compose/docker-compose.ids.yml ps

