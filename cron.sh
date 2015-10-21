#!/usr/bin/env bash

source /usr/local/rvm/environments/ruby-2.2.0@global

cd /srv/de-visa-notifier
ruby main.rb search 3230731 --email everm1nd.mail@gmail.com
