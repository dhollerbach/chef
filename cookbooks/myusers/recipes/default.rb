#
# Cookbook:: myusers
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

search("users", "platform:centos").each do |user_data|
  user user_data['id'] do
    comment user_data['comment']
    uid user_data['uid'].to_i
    gid user_data['gid'].to_i
    home user_data['home']
    shell user_data['shell']
  end
end

include_recipe 'myusers::groups'
