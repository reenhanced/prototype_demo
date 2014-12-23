Description
===========

Sets up the prototype application to be served in development mode

Local Setup
===========
It can be nice to run the tests on the local machine so debugging can be a little easier.

Here's how do to that (os x assumed):
```sh
brew update
brew install postgres
# Follow instructions to make it autostart
psql -h localhost
=# CREATE USER postgres WITH PASSWORD 'postgres' CREATEDB;
=# \q
bundle exec rake db:setup
```
