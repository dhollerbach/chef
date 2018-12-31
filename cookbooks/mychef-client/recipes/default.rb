#
# Cookbook:: mychef-client
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

node.default['chef_client']['interval'] = '300'
node.default['chef_client']['splay'] = '60'

include_recipe 'chef-client::default'
