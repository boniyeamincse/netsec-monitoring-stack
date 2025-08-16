# Administrator Guide

This guide provides instructions for administrators on how to add new devices and systems to the monitoring stack.

## Agent-Based Monitoring (Wazuh)

Agent-based monitoring is used for hosts (servers, workstations) where you can install a Wazuh agent to collect logs, file integrity data, and security events.

### Installing a Wazuh Agent

1.  **Log in to the target host.**
2.  **Download and install the Wazuh agent** for the appropriate operating system from the [Wazuh documentation](https://documentation.wazuh.com/current/installation-guide/wazuh-agent/index.html).
3.  **Edit the agent's configuration file** (`/var/ossec/etc/ossec.conf`) and set the `address` to the IP address of the Wazuh manager.

    ```xml
    <client>
      <server>
        <address>WAZUH_MANAGER_IP</address>
      </server>
    </client>
    ```

4.  **Start the Wazuh agent.**

    ```bash
    sudo systemctl start wazuh-agent
    ```

### Registering an Agent

1.  **On the Wazuh manager**, use the `wazuh-authd` service to register the new agent and get a key.
2.  **Import the key** on the agent using the `manage_agents` tool.

---

## Agentless Monitoring

Agentless monitoring is used for network devices like routers and switches where you cannot install an agent. Monitoring is performed using standard network protocols.

### SNMP (for LibreNMS)

1.  **Enable SNMPv3** on the network device.
2.  **Configure an SNMPv3 user** with a strong authentication and privacy password.
3.  **Add the device to LibreNMS** from the web UI, providing the IP address and SNMPv3 credentials.

### Syslog (for Wazuh)

1.  **Configure the network device** to send syslogs to the Wazuh manager's IP address on port `1514/tcp`.
2.  **Create custom rules** in `configs/wazuh/rules/local_rules.xml` to parse and alert on specific syslog messages if needed.

### NetFlow/sFlow/IPFIX (for ntopng)

1.  **Configure the network device** to export flows to the nProbe collector on port `2055/udp`.
2.  **Ensure the correct flow type** (NetFlow, sFlow, or IPFIX) is configured.

### Configuration Backups (for Oxidized)

1.  **Add a new entry** to the `configs/oxidized/devices.csv` file with the device's name and model.
2.  **Ensure Oxidized has SSH access** to the device with the credentials configured in `configs/oxidized/config`.
