christian academy prototype
=========

Installation instructions for OS X 10.7+:
_This assumes a stock out-of-the-box installation_

1. Install virtualbox (https://www.virtualbox.org/wiki/Downloads)
2. Install Xcode from the app store.
3. Install the command line tools from within Xcode (Xcode -> Preferences -> Downloads)
4. Install homebrew (http://mxcl.github.com/homebrew/)
5. Install git from homebrew:
  ```
    brew install git
  ```
6. Install vagrant (http://www.vagrantup.com/)
7. Vagrant dependencies
  ```
    vagrant plugin install vagrant-omnibus
  ```
7. Create directory for your virtual box:
  ```
    mkdir ~/VirtualBox\ VMs
  ```
8. Boot the virtual machine:
  ```
    ./boot.sh
  ```
10. Open the running site in your browser: http://localhost:3000/


Contact Nick (nhance@reenhanced.com) if you have any issues with this process or beyond this point.

Philosophies
=============

1. Choose the right tool for the job. No tool fits every need. Choose
   wisely and if you need to change tools, do it early.

2. Don't bring any dependencies on the environment. Use Vagrant to
   provide a consistent experience without machine concerns.

3. Host on digital ocean or heroku or AWS, bundle production into the
   project so it's always known.

4. Provide auditing and a fully tested stable base so you don't have to
   relearn good habits later. Start on the path and stay on it.
