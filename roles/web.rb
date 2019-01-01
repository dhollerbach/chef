name 'web'
description 'web server role'
run_list 'recipe[myusers]','recipe[workstation]','recipe[apache]','recipe[mychef-client]'
default_attributes({
  'apache-test' => {
    'attribute1' => 'hello from attribute 1',
    'attribute2' => 'youre great!'
  }
})
