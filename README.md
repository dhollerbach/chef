# OVERVIEW

This is a practice project for chef and is NOT intended for production use. It also has some helpful commands and tips for using or configuring chef.

## INSTALLATION
- Virtualbox - https://www.virtualbox.org/wiki/Downloads
- Vagrant - https://www.vagrantup.com/downloads.html
- Vagrant SCP - vagrant plugin install vagrant-scp
- Chef (localhost) - https://docs.chef.io/install_omnibus.html
- Chef (vagrant box) - curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.18.30
- ChefDK - https://downloads.chef.io/chefdk 

## COMMANDS

### Vagrant
- vagrant box add bento/centos-7.2 --provider=virtualbox
- vagrant init bento/centos-7.2  # Creates a Vagrantfile, which is used to specify virtual machine settings
- vagrant up  # Spins up the virutal machine using the Vagrantfile
- vagrant status  # Shows the status
- vagrant ssh-config  # Lists the connection details for running instances
- vagrant ssh  # SSH's into the vagrant box
- vagrant suspend  # Saves the machine state and shuts down the virtual machine
- vagrant resume  # Resumes the suspended virtual machine
- vagrant destroy --force  # Destroy all running virtual machines
- vagrant reload  # Reloads the vagrant box. Can be used after modifying the Vagrantfile - such as after enabling port fowarding (below)

### Chef

-z || --localmode  # Run on localhost
-r || --runlist  # Replace current run list with specified items
sudo chef-client -z <path_to_recipe>  # Runs a recipe locally
sudo chef-client -zr 'recipe[cookbook]'  # Runs the default recipe from the specified cookbook locally

## TIPS

### Vagrant

Enable port forwarding. In the Vagrantfile, uncomment the following the line. You can also add additional port forwardings by copying the following line and changing the port values.
- config.vm.network "forwarded_port", guest: 80, host: 8080

### Chef
Include Recipes - like adding them into your default recipe
- include_recipe 'cookbook::recipe'
