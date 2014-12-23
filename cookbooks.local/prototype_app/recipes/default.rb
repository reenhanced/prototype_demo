#
# Cookbook Name:: prototype_app
# Recipe:: default
#
# Note: See rvm defaults assigned in ../attributes/default.rb
#
ENV['LANGUAGE'] = ENV['LANG'] = ENV['LC_ALL'] = "en_US.UTF-8"

# RVM 1.26.0 added GPG signature checking, so we need to trust it
bash "trust rvm" do
  user 'root'
  code <<-EOF
  gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
  EOF
end

include_recipe "apt"
include_recipe "rvm::vagrant"
include_recipe "rvm::system"
include_recipe "vim"

include_recipe "postgresql::server"


# DEFAULT RUBY IS SET HERE.
# WHEN UPDATING .ruby-version MAKE SURE YOU UPDATE THIS!
rvm_default_ruby "ruby-2.1.5"

rvm_global_gem "bundler"
rvm_global_gem "rake"

bash "install dependencies" do
  user 'root'
  code <<-EOF
  apt-get install -y libqt4-dev
  apt-get install -y xvfb
  EOF
end

bash "bundle, then load default seed data" do
  cwd "/vagrant"
  user  'vagrant'
  group 'admin'

  # export Because: https://github.com/fnichol/chef-rvm/issues/69
  code <<-EOF
    export HOME=/home/vagrant USER=vagrant
    /usr/local/rvm/wrappers/default/bundle config --global path /home/vagrant/.bundler
    /usr/local/rvm/wrappers/default/bundle install
    /usr/local/rvm/wrappers/default/bundle exec rake db:setup
  EOF
end

