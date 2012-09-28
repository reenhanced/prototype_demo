#!/bin/sh
gem install vagrant
gem install librarian
gem install chef
librarian-chef install && vagrant up
