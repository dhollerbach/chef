# OVERVIEW

This is a practice project for chef and is NOT intended for production use. It also has some helpful commands and tips for using or configuring vagrant and chef.

# INSTALLATION / TOOLS
* **Virtualbox** - https://www.virtualbox.org/wiki/Downloads
* **Vagrant** - https://www.vagrantup.com/downloads.html
* **Vagrant SCP** - vagrant plugin install vagrant-scp
* **Vagrant-Ohai** - vagrant plugin install vagrant-ohai 
* **Chef (localhost)** - https://docs.chef.io/install_omnibus.html
* **Chef (vagrant box)** - curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.18.30
* **ChefDK** - https://downloads.chef.io/chefdk 
* **Chef Manage** - https://manage.chef.io
* **Rub Style Guide** - https://docs.chef.io/ruby.html
* **Inspec** - https://www.inspec.io/docs/reference/resources/

# COMMANDS

## Vagrant
* **vagrant box add bento/centos-7.2 --provider=virtualbox**
* **vagrant init bento/centos-7.2** - Creates a Vagrantfile, which is used to specify virtual machine settings
* **vagrant up** - Spins up the virutal machine using the Vagrantfile
* **vagrant status** - Shows the status
* **vagrant ssh-config** - Lists the connection details for running instances
* **vagrant ssh** - SSH's into the vagrant box
* **vagrant suspend** - Saves the machine state and shuts down the virtual machine
* **vagrant resume** - Resumes the suspended virtual machine
* **vagrant destroy --force** - Destroy all running virtual machines
* **vagrant reload** - Reloads the vagrant box. Can be used after modifying the Vagrantfile - such as after enabling port fowarding (below)

## Chef

### Switches
* **-z || --localmode** - Run on localhost
* **-r || --runlist** - Replace current run list with specified items

### Chef-Client
* **sudo chef-client** - Runs recipes from a chef server. Should be used on a node
* **sudo chef-client -z <path_to_recipe>** - Runs a recipe locally
* **sudo chef-client -zr 'recipe[cookbook::recipe]' - Runs a recipe from the specified cookbook locally
* **sudo chef-client -zr 'recipe[cookbook::recipe],recipe[cookbook::recipe]' - Runs multiple recipes locally. Note that there is NO space after the comma
* **sudo chef-client -zr 'recipe[cookbook]'** - Runs the default recipe from the specified cookbook locally

### Chef Generate
* **chef generate [cookbook | template | recipe]** - Creates a cookbook, template, or recipe, along with some other files (like files used for unit tests). Use these when creating new resources

### Chef Kitchen
* **kitchen init** - Generates a .kitchen.yml if one was not already created when the cookbook was created
* **kitchen list** - Shows which platforms you are going to create when using kitchen and what settings are in the .kitchen.yml file
* **kitchen create** - Creates the virtual machine(s) specified in the .kitchen.yml file
* **kitchen destroy** - Removes the virtual machine(s) specified in the .kitchen.yml file
* **kitchen login** - Logs into the virtual machine created by kitchen
* **kitchen converge** - Runs the recipes on the virtual machine(s) created by kitchen
* **kitchen verify** - Runs any tests that you have written against the virutal machine(s) using inspec

### ChefSpec

Unit testing framework for cookbooks

* **sudo chef exec rspec** - Generates the resources needed for a unit test. Then, runs the unit tests accordingly. This command should be run from within a cookbook

### Chef Knife

Primary means of communication with the chef server

#### Client
* **knife client list** - Checks if the workstation being used is a valid workstation. This means it has a valid key (.pem) and knife.rb. This should be run in the same directory as the .chef-repo directory

#### Node
* **knife node list** - Shows a list of nodes
* **knife node show <node_name>** - Shows more information about a particular node
* **knife node run_list add <node_name> 'recipe[cookbook],recipe[cookbook:recipe]'** - Adds the specified recipes on the specified node from the chef server

#### SSL
* **knife ssl check** - Checks if the workstation can communicate with the chef server

#### Cookbook
* **knife cookbook list** - Lists the cookbooks on the chef server
* **knife cookbook upload <cookbook_name>** - Uploads cookbooks to the chef server. This should be run in the same directory where the cookbooks directory is. You can use '-a' to upload all cookbooks

#### Bootstrap
* **knife bootstrap** - Installs the chef-client, runs ohai, converges the node, and saves the node object to the chef server (i.e. knife bootstrap FQDN -x USER -P PWD --sudo -N node_name || knife bootstrap localhost --p 2222 -x vagrant --sudo --i /.vagrant/machines/web1/virtualbox/private_key -N web1) 
* **knife bootstrap localhost -p 2222 -x vagrant --sudo --i /.vagrant/machines/load-balancer/virtualbox/private_key -N load-balancer --run-list 'recipe[myhaproxy]'** - Runs the bootstrap and run-list commands in one command

#### Role and SSH
* **knife role list** - Lists all of the roles on the chef server
* **knife role from file <path_to_file>** - Uploads a role from a file to the chef server
* **knife node run_list set web1 'role[role_name]'** - Sets a node to use a role and that role's run list
* **knife ssh localhost '<command>' --manual-list -p <port> -x <user> -i <identity_file>** - Runs a command to the machines specified (localhost in this case). These components can be found in vagrant using 'vagrant ssh-config'
* **knife ssh '*:*' -p <port> -x <user> '<command>'** - Runs a command using a search. In this case, *:* is ALL nodes
* **knife ssh 'role:web' -p <port> -x <user> '<command>'** - Runs a command on all nodes with a role of 'web'

#### Search
* **knife search <index> <search_query>** - Runs a search on the chef server. <index> can be 'client', 'environment', 'node', 'role', or the name of a 'data bag'. <search_query> is the format 'attribute:value'. If you use '*:*', it return everything
* **knife search node 'role:web AND recipes:apache'** - Searches for any nodes with a role of web and recipes containing the apache recipe
* **knife search role '*:*' -a name** - Searches for all nodes but only returns the name attributes

### Berks

Versions and dependencies manager for cookbooks

* **berks install** - Install all dependencies from the source in the Berksfile. This should be run from the cookbook directory you want to install dependencies for
* **berks upload** - Uploads the cookbook and its dependencies to the chef server. This should be run from the cookbook directory you want to upload. This command also checks for syntax errors

### Chef FoodCritic

Cookbook design best practices

* **sudo chef exec foodcritic <path_to_cookbook>** - Checks a cookbook for chef design best practices

### Chef Cookstyle

Ruby best practices tool for cookbooks. Aka: Rubocop

* **sudo chef exec cookstyle <path_to_cookbook>** - Checks a cookbook for ruby design best practices
* **ruby -c my_cookbook_file.rb** - Uses ruby to check a cookbook's Ruby syntax

## Additional ChefDK / Toolsets
* **kitchen** - Unit and integration testing

# TIPS

## Vagrant
* **Enable port forwarding. In the Vagrantfile, uncomment the following the line. You can also add additional port forwardings by copying the following line and changing the port values.**
  * config.vm.network "forwarded_port", guest: 80, host: 8080

## Chef
* **Include Recipes - like adding them into your default recipe**
  * include_recipe 'cookbook::recipe'

* **ChefDK Tools Aren't Working or Aren't Available**
  * chef exec <tool_name>

* **Specify platforms, drivers (vagrant, ec2, etc), and recipes for chef kitchen to test against**
  * If you generated a cookbook using chef generate, a .kitchen.yml file is automatically built for you in that cookbook's directory. Edit this file to add platforms, recipes, or other resources you'd like to test against.

* **Supermarkets - should I use the public one or make a private one?**
  * Depends on your needs but if you want a private one, it's common to make a GitHub repo and keep your cookbooks there. You could also create a supermarket internally link a url to it. Just be sure to change the Berksfile 'source' in your cookbook to that new link or url

* **How do I make chef-client run on a schedule?**
  * Go to https://supermarket.chef.io and go to the chef-client cookbook.
