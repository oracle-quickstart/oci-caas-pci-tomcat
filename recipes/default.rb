#
# Cookbook:: oci_caas_pci_tomcat
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
include_recipe '::base'
include_recipe '::tomcat'
include_recipe '::firewalld'
include_recipe 'wazuh_agent::default'