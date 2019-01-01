name 'load-balancer'
description 'load-balancer server role'
run_list 'role[base]', 'recipe[workstation]', 'recipe[myhaproxy]'
