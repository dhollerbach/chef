package ['tree', 'git', 'ntp']

template '/etc/motd' do
  source 'motd.erb'
  variables(
    :name => 'Dave Hollerbach'
  )
  owner 'root'
  group 'root'
end

user 'user1' do
  comment 'user1'
  uid '123'
  home '/home/user1/'
  shell '/bin/bash'
end

group 'admins' do
  members 'user1'
  append true
end
