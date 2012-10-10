bridgeway
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
6. Install vagrant:
  ```
    sudo gem install vagrant
  ```
7. Install librarian:
  ```
    sudo gem install librarian
  ```
8. Boot the virtual machine:
  ```
    ./boot.sh
  ```
9. Start the server:
  ```
    script/server
  ```
10. Open the running site in your browser: http://localhost:3000/


Contact Nick (nhance@reenhanced.com) if you have any issues with this process or beyond this point.
