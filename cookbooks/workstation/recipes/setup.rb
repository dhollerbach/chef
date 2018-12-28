package ['tree', 'git', 'ntp'] do
  action :install
end

template '/etc/motd' do
  action :create
  source 'motd.erb'
  variables(
    :name => 'Dave Hollerbach'
  )
end
