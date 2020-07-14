#
# Cookbook:: oci_caas_pci_tomcat
# Recipe:: tomcat
#
# Copyright:: 2020, The Authors, All Rights Reserved.

package 'jdk1.8'
tomcat_version = node['tomcat_version']
package_cache = node['package_cache']

tomcat_install 'webapp' do
  tarball_path "#{package_cache}/apache-tomcat-#{tomcat_version}.tar.gz"
  version tomcat_version

  # Required for tarball_path installation
  verify_checksum false

  # Keeping docs for validation
  exclude_docs false

  exclude_examples true
  exclude_manager true
  exclude_hostmanager true
end

# Drop off our own server.xml that uses a non-default port setup
template '/opt/tomcat_webapp/conf/server.xml' do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    shutdown_port: node['shutdown_port'],
    http_port: node['http_port'],
    https_port: node['https_port']
  )
  notifies :restart, 'tomcat_service[webapp]'
end

# start the webapp tomcat service using a non-standard pic location
tomcat_service 'webapp' do
  action [:start, :enable]
  env_vars [{ 'CATALINA_BASE' => '/opt/tomcat_webapp/' }, { 'CATALINA_PID' => '/opt/tomcat_webapp/bin/non_standard_location.pid' }]
  sensitive true
  tomcat_user 'tomcat_webapp'
  tomcat_group 'tomcat_webapp'
end