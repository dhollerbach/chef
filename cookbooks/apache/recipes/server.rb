#
# Cookbook Name:: apache
# Recipe:: server
#
# Copyright (c) 2018 The Authors, All Rights Reserved.

# notifies :action, 'resource[name]', :timer
# subscribes :action, 'resource[name]', :timer
#
# :before, :delayed, :immediately

package 'httpd'

remote_file '/var/www/html/derp_kitty.jpg' do
  source 'https://i.imgur.com/JWxxL.jpg'
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  notifies :restart, 'service[httpd]', :immediately
end

service 'httpd' do
  action [:enable, :start]
end
