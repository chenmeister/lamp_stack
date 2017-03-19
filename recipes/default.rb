#
# Cookbook:: lamp_stack
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'selinux::permissive'
include_recipe 'lamp_stack::firewall'
include_recipe 'lamp_stack::web_user'
include_recipe 'lamp_stack::web'
include_recipe 'lamp_stack::database'