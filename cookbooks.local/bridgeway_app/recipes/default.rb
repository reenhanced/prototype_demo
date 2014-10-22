#
# Cookbook Name:: bridgeway_app
# Recipe:: default
#
ENV['LANGUAGE'] = ENV['LANG'] = ENV['LC_ALL'] = "en_US.UTF-8"

include_recipe "apt"
include_recipe "rvm::vagrant"
include_recipe "rvm::system"
include_recipe "vim"

include_recipe "postgresql::server"


# Note: See rvm defaults assigned in ../attributes/default.rb
rvm_default_ruby "ruby-2.1.2"
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
    env
    /usr/local/rvm/wrappers/default/bundle install --path /home/vagrant/.bundler
    /usr/local/rvm/wrappers/default/bundle exec rake db:setup
  EOF
end

