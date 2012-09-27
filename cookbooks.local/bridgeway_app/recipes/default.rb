#
# Cookbook Name:: bridgeway_app
# Recipe:: default
#

include_recipe "apt"
include_recipe "rvm"

bash "install dependencies" do
  user 'root'
  code <<-EOF
  apt-get update
  apt-get upgrade -y
  apt-get install -y libqt4-dev
  EOF
end

rvm_global_gem "bundler" do
  action :install
end

rvm_shell "bundle, then load default seed data" do
  cwd "/vagrant"
  user  'vagrant'
  group 'vagrant'

  # Because: https://github.com/fnichol/chef-rvm/issues/69
  environment 'USER' => 'vagrant',
              'HOME' => '/home/vagrant'

  code <<-EOF
    export HOME=/home/vagrant USER=vagrant
    bundle install
    bundle exec rake db:setup
  EOF
end

