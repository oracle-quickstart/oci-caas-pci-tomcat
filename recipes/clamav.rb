#
# Cookbook:: oci_caas_pci_tomcat
# Recipe:: clamav
#
include_recipe 'yum-epel'
include_recipe "clamav::services"

cookbook_file '/etc/yum.repos.d/oracle-linux-ol7.repo' do
  source 'oracle-linux-ol7.repo'
  owner 'root'
  group 'root'
  mode '0644'
end

yum_options = []
package_list = case node['platform']
               when 'amazon'
                 yum_options << '--disablerepo=epel'
                 %w(clamav clamav-update clamd)
               else
                 if node['platform_version'].to_i >= 7
                   %w(clamav clamav-update)
                 else
                   %w(clamav clamav-db clamd)
                 end
               end

package 'clamav-server'

package_list.each do |pkg|
  package "install #{pkg}" do
    package_name pkg
    action :install
    version node['clamav']['version'] if node['clamav']['version']
    options yum_options.join(' ')

    # Give it an arch or YUM will try to install both i386 and x86_64 versions
    # arch node['kernel']['machine']
    if node['clamav']['clamd']['enabled']
      notifies :restart,
               "service[#{node['clamav']['clamd']['service']}]"
    end
    if node['clamav']['freshclam']['enabled']
      notifies :restart,
               "service[#{node['clamav']['freshclam']['service']}]"
    end
  end
end

yum_package 'clamav-devel' do
  action :install
  version node['clamav']['version'] if node['clamav']['version']
  arch node['kernel']['machine']
  only_if { node['clamav']['dev_package'] }
end

template "/etc/init.d/#{node['clamav']['clamd']['service']}" do
  source 'clamd.init.rhel.erb'
  cookbook 'clamav'
  mode '0755'
  action :create
  variables(
    clamd_conf: "#{node['clamav']['conf_dir']}/clamd.conf",
    clamd_pid: node['clamav']['clamd']['pid_file'],
    clamd_bin_dir: '/usr/sbin'
  )
end

template "/etc/init.d/#{node['clamav']['freshclam']['service']}" do
  source 'freshclam.init.rhel.erb'
  cookbook 'clamav'
  mode '0755'
  action :create
  variables(
    freshclam_conf: "#{node['clamav']['conf_dir']}/freshclam.conf",
    freshclam_pid: node['clamav']['freshclam']['pid_file'],
    freshclam_bin_dir: '/usr/bin'
  )
end

template '/etc/sysconfig/freshclam' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'freshclam.sysconfig.erb'
  cookbook 'clamav'
  action :create
  variables(
    rhel_cron_disable: node['clamav']['freshclam']['rhel_cron_disable']
  )
end

user 'clam' do
  action :remove
  not_if { node['clamav']['user'] == 'clam' }
end

include_recipe "clamav::users"
include_recipe "clamav::logging"
include_recipe "clamav::freshclam"
include_recipe "clamav::clamd"
include_recipe "clamav::clamav_scan"