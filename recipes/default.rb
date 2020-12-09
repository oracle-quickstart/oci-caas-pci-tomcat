#
# Cookbook:: oci_caas_pci_tomcat
# Recipe:: default
#
include_recipe 'oci_caas_base::base'
include_recipe '::tomcat'
include_recipe '::firewalld'
include_recipe 'oci_caas_base::clamav'
include_recipe 'oci_caas_base::suricata'
include_recipe 'oci_caas_base::scanning'
include_recipe 'wazuh_agent::default'

# Final recipe to run in the cookbook
include_recipe '::final'