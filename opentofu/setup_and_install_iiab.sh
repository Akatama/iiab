#!/bin/bash

git clone -b deploy_24hrs https://github.com/Akatama/iiab.git
sudo mkdir /opt/iiab
sudo mv ./iiab /opt/iiab
sudo mkdir /etc/iiab
sudo cp /opt/iiab/iiab/vars/local_vars_small_maps.yml /etc/iiab/local_vars.yml
cd /opt/iiab/iiab
sudo ./scripts/ansible
sudo ./iiab-install
