name 'base'
description 'base role for all servers'
run_list 'recipe[myusers]','recipe[mychef-client]'
