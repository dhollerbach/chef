# OVERVIEW

This is a practice project for chef and is NOT intended for production use. It also has some helpful commands and tips for using or configuring vagrant and chef.

# INSTALLATION / TOOLS
* **Virtualbox** - https://www.virtualbox.org/wiki/Downloads
* **Vagrant** - https://www.vagrantup.com/downloads.html
* **Vagrant SCP** - vagrant plugin install vagrant-scp
* **Chef (localhost)** - https://docs.chef.io/install_omnibus.html
* **Chef (vagrant box)** - curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.18.30
* **ChefDK** - https://downloads.chef.io/chefdk 
* **Rub Style Guide** - https://docs.chef.io/ruby.html

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
* **sudo chef-client -z <path_to_recipe>** - Runs a recipe locally
* **sudo chef-client -zr 'recipe[cookbook::recipe]' - Runs a recipe from the specified cookbook locally
* **sudo chef-client -zr 'recipe[cookbook::recipe],recipe[cookbook::recipe]' - Runs multiple recipes locally. Note that there is NO space after the comma
* **sudo chef-client -zr 'recipe[cookbook]'** - Runs the default recipe from the specified cookbook locally

### Chef Generate
* **sudo chef generate [cookbook | template | recipe]** - Creates a cookbook, template, or recipe, along with some other files (like files used for unit tests). Use these when creating new resources

### Chef Kitchen
* **sudo chef kitchen init** - Generates a .kitchen.yml if one was not already created when the cookbook was created

### Chef Troubleshooting / Best Practices
* **sudo chef exec foodcritic <path_to_cookbook>** - Checks a cookbook for chef design best practices
* **sudo chef exec cookstyle <path_to_cookbook>** - Checks a cookbook for ruby design best practices
* **ruby -c my_cookbook_file.rb** - Uses ruby to check a cookbook's Ruby syntax

## ChefDK / Toolsets
* **berks** - Versions and dependencies manager for cookbooks
* **kitchen** - Unit and integration testing
* **knife** - Primary means of communication with a chef server
* **cookstyle** - Ruby best practices tool for cookbooks. Aka: Rubocop
* **foodcritic** - Cookbook design best practices

# TIPS

## Vagrant
* **Enable port forwarding. In the Vagrantfile, uncomment the following the line. You can also add additional port forwardings by copying the following line and changing the port values.**
  * config.vm.network "forwarded_port", guest: 80, host: 8080

## Chef
* **Include Recipes - like adding them into your default recipe**
  * include_recipe 'cookbook::recipe'

* **ChefDK Tools Aren't Working or Aren't Available**
  * chef exec <tool_name>

* **Specify platforms or recipes for chef kitchen to test against**
  * If you generated a cookbook using chef generate, a .kitchen.yml file is automatically built for you in that cookbook's directory. Edit this file to add platforms, recipes, or other resources you'd like to test against.
