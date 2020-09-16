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

# Install, configure, and enable chrony client
package 'chrony'

cookbook_file '/etc/chrony.conf' do
  source 'chrony.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'chronyd' do
  action :enable
end

template "#{node['ossec']['dir']}/etc/shared/agent.conf" do
  source 'wazuh_local_files.conf'
  owner 'root'
  group 'ossec'
  action :create
end