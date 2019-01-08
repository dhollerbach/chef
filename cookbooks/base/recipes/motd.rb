#
# Cookbook:: base
# Recipe:: motd
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Sets the message of the day
template '/etc/motd' do
  source 'motd.erb'
  owner 'root'
  group 'root'
end
