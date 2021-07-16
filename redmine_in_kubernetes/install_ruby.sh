#!/bin/bash

echo '-----Instal rvm-----'
sudo apt-get install software-properties-common -y
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm -y
sudo usermod -a -G rvm $USER
ls -la $(which rvm)
echo '-----Instal ruby 2.7.2-----'
#/usr/share/rvm/bin/rvm
rvm install 2.7.2
#/usr/share/rvm/rubies/ruby-2.7.2/bin/gem
echo '-----Instal bundler-----'
gem install bundler
echo '-----Instal rails 5.2-----'
gem install rails --version=5.2.6
