#
# Cookbook:: oci_caas_pci_tomcat
# Recipe:: base
#
# Copyright:: 2020, The Authors, All Rights Reserved.

cron 'chef_client' do
  action :create
  minute '0,15,30,45'
  user 'root'
  home '/opt/oci-caas/chef'
  command 'chef-client -z --runlist oci_caas_pci_tomcat -j /opt/oci-caas/chef/attributes.json'
end