require 'yaml'

CONFIG = YAML.load(File.open('config.yml'))

require './notifier'

Notifier.start(ARGV)
