require 'yaml'

@@config = YAML.load(File.open('config.yml'))

require './notifier'

Notifier.start(ARGV)
