#
# Cookbook:: lamp_stack
# Recipe:: web
#
# Copyright:: 2017, The Authors, All Rights Reserved.
httpd_service 'customers' do
  mpm 'prefork'
  action [:create, :start]
end

httpd_config 'customers' do
  instance 'customers'
  source 'customers.conf.erb'
  notifies :restart, 'httpd_service[customers]'
end

directory node['lamp_stack']['document_root'] do
  recursive true
end

template"#{node['lamp_stack']['document_root']}/index.php" do
  source 'index.php.erb'
  mode '0644'
  owner node['lamp_stack']['user']
  group node['lamp_stack']['group']
end

httpd_module 'php' do
  instance 'customers'
end

package 'php-mysql' do
  action :install
  notifies :restart, 'httpd_service[customers]'
end
