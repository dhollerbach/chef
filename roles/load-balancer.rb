name 'load-balancer'
description 'load-balancer server role'
run_list 'recipe[workstation]','recipe[myhaproxy]','recipe[mychef-client]'
