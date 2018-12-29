OVERVIEW
This is a practice project for chef and is NOT intended for production use. It also has some helpful commands and tips for using or configuring chef.

INSTALLATION
- Virtualbox - https://www.virtualbox.org/wiki/Downloads
- Vagrant - https://www.vagrantup.com/downloads.html
- Chef (localhost) - https://docs.chef.io/install_omnibus.html
- Chef (vagrant box) - curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.18.30
- ChefDK - 

COMMANDS
~Vagrant~
- vagrant box add bento/centos-7.2 --provider=virtualbox
- vagrant init bento/centos-7.2  # initializes a new Vagrant environment by creating a Vagrantfile with the specified OS
- vagrant up  # Boots up the vagrant box
- vagrant status  # Shows the status
- vagrant ssh-config  # Shows the ssh-config for the vagrant box
- vagrant ssh  # SSH's into the vagrant box
- vagrant suspend  # Supsends the vagrant box
- vagrant resume  # Resumes the vagrant box
- vagrant destroy --force  # Deletes the vagrant box


~Chef~
-z || --localmode  # Run on localhost
-r || --runlist  # Replace current run list with specified items
sudo chef-client -z <path_to_recipe>  # Runs a recipe locally
sudo chef-client -zr 'recipe[cookbook]'  # Runs the default recipe from the specified cookbook locally

TIPS
~Chef~
# Include Recipes - like adding them into your default recipe
- include_recipe 'cookbook::recipe'
