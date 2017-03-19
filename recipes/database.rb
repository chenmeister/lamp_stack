#
# Cookbook:: lamp_stack
# Recipe:: database
#
# Copyright:: 2017, The Authors, All Rights Reserved.

mysql_client 'default' do
  action :create
end

mysql_service 'default' do
  initial_root_password node['lamp_stack']['database']['root_password']
  action [:create, :start]
end

mysql2_chef_gem 'default' do
  action :install
end

mysql_database node['lamp_stack']['database']['dbname'] do
  connection(
    :host => node['lamp_stack']['database']['host'],
    :username => node['lamp_stack']['database']['root_username'],
    :password => node['lamp_stack']['database']['root_password'] 
  )
  action :create
end

mysql_database_user node['lamp_stack']['database']['admin_username'] do
  connection(
    :host => node['lamp_stack']['database']['host'],
    :username => node['lamp_stack']['database']['root_username'],
    :password => node['lamp_stack']['database']['root_password']
  )
  password node['lamp_stack']['database']['admin_password']
  database_name node['lamp_stack']['database']['dbname']
  host node['lamp_stack']['database']['host']
  action [:create, :grant]
end

create_tables_script_path = File.join(Chef::Config[:file_cache_path], 'create-tables.sql')

cookbook_file create_tables_script_path do
  source 'create-tables.sql'
  owner 'root'
  group 'root'
  mode '0600'
end

execute "initialize #{node['lamp_stack']['database']['dbname']} database" do
  command "mysql -h #{node['lamp_stack']['database']['host']} -u #{node['lamp_stack']['database']['admin_username']} -p#{node['lamp_stack']['database']['admin_password']} -D #{node['lamp_stack']['database']['dbname']} < #{create_tables_script_path}"
  not_if  "mysql -h #{node['lamp_stack']['database']['host']} -u #{node['lamp_stack']['database']['admin_username']} -p#{node['lamp_stack']['database']['admin_password']} -D #{node['lamp_stack']['database']['dbname']} -e 'describe customers;'"
end