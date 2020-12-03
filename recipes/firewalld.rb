#
# Cookbook:: oci_caas_pci_tomcat
# Recipe:: firewalld
#

firewalld_rich_rule 'ssh_add' do
  zone 'public'
  family 'ipv4'
  source_address node['vcn_cidr_block']
  port_number '22'
  port_protocol 'tcp'
  log_prefix 'ssh'
  log_level 'info'
  firewall_action 'accept'
  action :add
end

firewalld_rich_rule 'tomcat_http_port_add' do
  zone 'public'
  family 'ipv4'
  source_address node['vcn_cidr_block']
  port_number node['http_port']
  port_protocol 'tcp'
  log_prefix 'tomcat_http'
  log_level 'info'
  firewall_action 'accept'
  action :add
end

firewalld_rich_rule 'tomcat_https_port_add' do
  zone 'public'
  family 'ipv4'
  source_address node['vcn_cidr_block']
  port_number node['https_port']
  port_protocol 'tcp'
  log_prefix 'tomcat_https'
  log_level 'info'
  firewall_action 'accept'
  action :add
end