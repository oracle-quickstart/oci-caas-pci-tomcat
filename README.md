# oci_caas_pci_tomcat Cookbook

## Description
This cookbook will install Tomcat and an application war file, set up firewall
rules, and configure additional requirements to deploy into a PCI compliant
envrionment.

## Requirements

### Platforms
* Oracle Autonomous Linux 7.8+

### Chef
* Chef 16+

### Cookbooks
* oci_caas_base
* firewalld
* tomcat
* wazuh_agent

## Attributes
* node['ossec']['address'] - Wazuh (ossec) server address
* node['ossec']['registration_address'] - Registration address for Wazuh
* node['runlist_name'] - The runlist name used for scheduling Chef via cron
* node['tomcat_version'] - The version of Tomcat being installed 
* node['shutdown_port'] - The Tomcat "shutdown port"
* node['http_port'] - The port to use for http traffic
* node['https_port'] - The port to use for https traffic
* node['app_war_file'] - The application war file
* node['package_cache'] - Location on disk where the war file and Tomcat are stored
* node['oci_caas_etc'] - Configuration directory, contains secrets
* node['vcn_cidr_block'] - CIDR block used for inbound firewall rules

## Recipes
### default
The default recipe will run all required recipes in the recommended order.

### firewalld
Managed firewall rules using firewall-cmd

### tomcat
Deploys Tomcat, an application war file, and required components.

### final
Last recipe in the run list. A catch-all to make sure it runs
after all other recipes.

## Usage
This is intended to be a complete wrapper cookbook for the environment. You can run
everything via the default cookbook.

## License
Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.

Licensed under the Universal Permissive License 1.0

See [LICENSE](LICENSE) for more details.