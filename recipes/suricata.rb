#
# Cookbook:: oci_caas_pci_tomcat
# Recipe:: suricata
#

include_recipe 'yum-epel'

package 'suricata' do
  action :install
end

execute 'suricata-update' do
  command '/bin/suricata-update'
  creates '/var/lib/suricata/rules/suricata.rules'
  action :run
end

template '/etc/sysconfig/suricata' do
  source 'suricata.sysconfig'
  mode '0400'
  action :create
end

cron 'suricata_update' do
  action :create
  minute '13'
  hour '1'
  user 'root'
  command '/bin/suricata-update'
end

service 'suricata' do
  action [ :enable, :start ]
end