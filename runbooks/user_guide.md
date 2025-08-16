# User Guide

This guide provides an overview of the network security monitoring stack and how to use its different components.

## Accessing the Tools

Here are the web interfaces for the various tools in the stack. Replace `<server-ip>` with the IP address of the monitoring server.

*   **Wazuh Dashboard:** `http://<server-ip>:5601`
*   **LibreNMS:** `http://<server-ip>:8000`
*   **NetBox:** `http://<server-ip>:8001`
*   **ntopng:** `http://<server-ip>:3000`
*   **Oxidized:** `http://<server-ip>:8888`
*   **TheHive:** `http://<server-ip>:9000`
*   **Cortex:** `http://<server-ip>:9001`
*   **MISP:** `https://<server-ip>:8443`

## Using the Tools

### Wazuh (Security Information and Event Management)

*   **Purpose:** View security alerts, compliance reports, and analyze logs from all monitored devices and hosts.
*   **How to use:** Navigate to the dashboard to see an overview of security events. Use the `Security Events` tab to investigate specific alerts.

### LibreNMS (Network Monitoring System)

*   **Purpose:** Monitor the health and performance of network devices.
*   **How to use:** Search for a device to view its graphs for bandwidth, CPU, memory, and other metrics. The `Health` tab provides an overview of all devices.

### ntopng (Network Traffic Analysis)

*   **Purpose:** Analyze network traffic in real-time.
*   **How to use:** Use the `Flows` tab to see a list of all active network connections. The `Hosts` tab provides information about top talkers and traffic destinations.

### NetBox (IPAM/DCIM)

*   **Purpose:** The source of truth for all network assets, including IP addresses, VLANs, devices, and racks.
*   **How to use:** Browse the different sections to find information about the network infrastructure.

### TheHive (Incident Response Platform)

*   **Purpose:** Manage and collaborate on security incidents.
*   **How to use:** View open cases, create new cases from alerts, and add observables for investigation.
