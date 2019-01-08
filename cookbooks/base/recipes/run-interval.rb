#
# Cookbook:: base
# Recipe:: run-interval
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Runs every 5 minutes
node.default['chef_client']['interval'] = '300'
node.default['chef_client']['splay'] = '60'

include_recipe 'chef-client::default'
