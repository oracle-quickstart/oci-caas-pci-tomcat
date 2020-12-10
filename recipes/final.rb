#
# Cookbook:: oci_caas_pci_tomcat
# Recipe:: final
#

# Wazuh agent config for local file monitoring
template "#{node['ossec']['dir']}/etc/shared/agent.conf" do
  source 'wazuh_local_files.conf'
  owner 'root'
  group 'ossec'
  action :create
end