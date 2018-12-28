#
# Cookbook Name:: apache
# Recipe:: server
#
# Copyright (c) 2018 The Authors, All Rights Reserved.

package ['httpd'] do
  action :install
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  action :create
end

service 'httpd' do
  action [ :enable, :start ]
end
