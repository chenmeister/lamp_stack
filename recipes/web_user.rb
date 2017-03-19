#
# Cookbook:: lamp_stack
# Recipe:: web_user
#
# Copyright:: 2017, The Authors, All Rights Reserved.
group node['lamp_stack']['group']

user node['lamp_stack']['user'] do
  group node['lamp_stack']['group']
  system true
  shell '/bin/bash'
end
