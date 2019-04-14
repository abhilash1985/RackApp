# This file is used by Rack-based servers to start the application.
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'yaml'
require 'sequel'
require 'mysql2'
require 'json'
require 'user'
require 'db_config'
require 'routes'

run User.app
